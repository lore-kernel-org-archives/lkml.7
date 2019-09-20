Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ACA1C49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 06:08:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7027720882
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 06:08:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568959698;
	bh=mWG1Jx2zQxwa3AhlOl1Bm5pNoGL7+pi+3Zp+OGk4y08=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=1jv6fxCs6F6Bxr0CtjFppwtQol4Z43eHrKvrZ8r+LPfkaJltmnpZh+yfOnQYxeGQu
	 ZIIPOheqtO1xEc7tly7wT+acvU179MNnxl8NaoX3JqvVKoCeqEMARMtznyYceEciZ4
	 gyfg8aYrqylXJFiBvMBkvFvjKFU09L8SrQnlcQA0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437219AbfITGIR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 02:08:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:48136 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2408261AbfITGIR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 02:08:17 -0400
Received: from localhost (unknown [145.15.244.23])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 64BDD20644;
        Fri, 20 Sep 2019 06:08:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568959696;
        bh=mWG1Jx2zQxwa3AhlOl1Bm5pNoGL7+pi+3Zp+OGk4y08=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2V3AKCpsCLu6C7lLk2VhFP/kd1dLmiut0wOoF7UVzSCoGo/Viq+ocwIZ3niFWS/Nk
         ABbbBTIr4/z+SZybxUOxzaVdCh/+qKeTqxBEGwM7cX+cizCcBq8dQLKFEslwf1OfZw
         kGPmNcztrnil27xJkwTiTQudpQE9bUmzvByDcp+I=
Date:   Fri, 20 Sep 2019 08:08:12 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Ayman Bagabas <ayman.bagabas@gmail.com>
Cc:     Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Sinan Kaya <okaya@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Takashi Iwai <tiwai@suse.de>,
        Stuart Hayes <stuart.w.hayes@gmail.com>,
        Matan Ziv-Av <matan@svgalib.org>,
        Hans de Goede <hdegoede@redhat.com>,
        "Enrico Weigelt, metux IT consult" <info@metux.net>,
        Peng Hao <peng.hao2@zte.com.cn>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Mattias Jacobsson <2pi@mok.nu>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/6] platform/x86: huawei-wmi: Add quirks and module
 parameters
Message-ID: <20190920060812.GB473898@kroah.com>
References: <20190920003938.21617-1-ayman.bagabas@gmail.com>
 <20190920003938.21617-3-ayman.bagabas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190920003938.21617-3-ayman.bagabas@gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 19, 2019 at 08:39:07PM -0400, Ayman Bagabas wrote:
> Introduce quirks and module parameters. 3 quirks are added:
> 1. Fixes reporting brightness keys twice since it's already handled by
>    acpi-video.
> 2. Some models need a short delay when setting battery thresholds to
>    prevent a race condition when two processes read/write. (will be used later)
> 3. Matebook X (2017) handles micmute led through the "legacy" interface
>    which is not currently implemented. Use ACPI EC method to control
>    this led. (will be used later)
> 
> 2 module parameters are added to enable this short delay and/or report
>   brightness keys through this driver.

module parameters are a pain to manage and handle over time.  Is there
any way you can "automatically" figure this out, or use a sysfs file
instead?

thanks,

greg k-h
