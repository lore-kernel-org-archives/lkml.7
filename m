Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF2E5C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 14:46:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1B8522B48
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 14:46:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576161991;
	bh=LQ+QqJke3k2uOefv9MNRRbl/t4c8KgxsP2Atg7f46Sk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=tZAUpYDhn2ChAbnw1c/3ZAvo7l566i8bJ2ujbrDmreBBVpr6FpWk2DGQ/JQ1l200r
	 Kasct2kA59BG2CxYHbggsnDkodCrzQuKXtu1547x11X58F4IMyQMa1c1fWPLsDCQ8I
	 PAHMbeqgajy513QNxeFjAoGq5IdSPqedJz1WbXZ4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729734AbfLLOqa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 09:46:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:58728 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729266AbfLLOqa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 09:46:30 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 595D222527;
        Thu, 12 Dec 2019 14:46:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576161989;
        bh=LQ+QqJke3k2uOefv9MNRRbl/t4c8KgxsP2Atg7f46Sk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Q9ZKtIix0AD1Yhhr/dobmWey6VrOfRRFSLp1tg88whojYHHs/V2riyUdxMolNs+ll
         Y5DdjM60CyH5pmEfLudLH3sPFfCghNUCcaP1I0fIBps6GudlXY30fjd36i6JNKkEMS
         aZ6zJ8oFrGyKefLK6NNuQ+OtUgv/+M/qbJsY3q+E=
Date:   Thu, 12 Dec 2019 15:46:27 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Vitor Soares <Vitor.Soares@synopsys.com>
Cc:     linux-kernel@vger.kernel.org, linux-i3c@lists.infradead.org,
        Joao.Pinto@synopsys.com, bbrezillon@kernel.org, wsa@the-dreams.de,
        arnd@arndb.de, broonie@kernel.org
Subject: Re: [RFC 5/5] i3c: add i3cdev module to expose i3c dev in /dev
Message-ID: <20191212144627.GC1668196@kroah.com>
References: <cover.1575977795.git.vitor.soares@synopsys.com>
 <f9f20eaf900ed5629dd3d824bc1e90c7e6b4a371.1575977795.git.vitor.soares@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f9f20eaf900ed5629dd3d824bc1e90c7e6b4a371.1575977795.git.vitor.soares@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 10, 2019 at 04:37:33PM +0100, Vitor Soares wrote:
> +static struct i3cdev_data *i3cdev_get_by_minor(unsigned int minor)

Why?  Why not just embed the structure in the cdev if you really need
it?

> +static struct i3cdev_data *get_free_i3cdev(struct i3c_device *i3c)
> +{
> +	struct i3cdev_data *i3cdev;
> +	unsigned long minor;
> +
> +	minor = find_first_zero_bit(minors, N_I3C_MINORS);

No locking, fun!!!

:(

Why not use an idr instead, that is what it is there for.  Don't try to
roll your own.

thanks,

greg k-h
