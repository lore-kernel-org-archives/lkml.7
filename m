Return-Path: <SRS0=HfRD=XN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4DA5C4CEC9
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 11:05:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E15321924
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 11:05:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568804752;
	bh=cfR8cp9RXeCZCrpG8ViPCQUuSx8Z3CiXOPGljSApjEA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=CaQmga6YWCnEj/JTA9Mlk1ukhuVbYtCrU4YZY6swVdaUl9+ikWNtu0jwBtb4Jua12
	 k+ff6dur+RcsBRzxjloT9OVY58Mh38k8oTwY+hY4Hoza7PvCfEaSTBEenvRugOHGFU
	 SwnrBTRJwiDq1emR3UlbzoYk2uy/Ujosdv1RdUNg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729630AbfIRLFw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 07:05:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:55322 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726277AbfIRLFv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 07:05:51 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4F02021920;
        Wed, 18 Sep 2019 11:05:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568804750;
        bh=cfR8cp9RXeCZCrpG8ViPCQUuSx8Z3CiXOPGljSApjEA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0YZh2szIeQm27pXuTKLTHYih2e1HECMwYocnHTSG9EoPMofO3/COjdSNlWDhwV1tJ
         m8rytbtGAGoOHCTrH8gziPc9Ms+RY7KfdFmcqxaLBjr0cUv3Kc2eGEFQpgnE+BAzFA
         u2rg867+6ogshkqIuzNJLXQuGaDpWN2vuBZnyWco=
Date:   Wed, 18 Sep 2019 13:05:48 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Ju Hyung Park <qkrwngud825@gmail.com>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        devel@driverdev.osuosl.org, linkinjeon@gmail.com,
        Valdis Kletnieks <valdis.kletnieks@vt.edu>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Namjae Jeon <namjae.jeon@samsung.com>,
        linux-kernel@vger.kernel.org, alexander.levin@microsoft.com,
        sergey.senozhatsky@gmail.com, linux-fsdevel@vger.kernel.org,
        sj1557.seo@samsung.com
Subject: Re: [PATCH] staging: exfat: add exfat filesystem code to
Message-ID: <20190918110548.GA1894362@kroah.com>
References: <CAD14+f1adJPRTvk8awgPJwCoHXSngqoKcAze1xbHVVvrhSMGrQ@mail.gmail.com>
 <004401d56dc9$b00fd7a0$102f86e0$@samsung.com>
 <20190918061605.GA1832786@kroah.com>
 <20190918063304.GA8354@jagdpanzerIV>
 <20190918082658.GA1861850@kroah.com>
 <CAD14+f24gujg3S41ARYn3CvfCq9_v+M2kot=RR3u7sNsBGte0Q@mail.gmail.com>
 <20190918092405.GC2959@kadam>
 <CAD14+f1yQWoZH4onJwbt1kezxyoHW147HA-1p+U0dVo3r=mqBw@mail.gmail.com>
 <20190918100803.GD2959@kadam>
 <CAD14+f1yT2_d8RP2a2NqAVYAkmB4ti6KjSsV2sM8SVCOQ_M=RQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD14+f1yT2_d8RP2a2NqAVYAkmB4ti6KjSsV2sM8SVCOQ_M=RQ@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 18, 2019 at 07:46:25PM +0900, Ju Hyung Park wrote:
> On Wed, Sep 18, 2019 at 7:09 PM Dan Carpenter <dan.carpenter@oracle.com> wrote:
> > Use Kconfig.
> 
> Not just that.
> There are a lot of non-static functions that's not marked ex/sdfat-specific.
> (which we would have to clean it up eventually)

Then clean them up :)

> Even with sdFAT base, there are some non-static functions named as exfat.

Then just force both filesystems to only be built as a module and all
should be fine, right?

> Figuring out a solution for this is pretty pointless imho when one of
> the drivers will be dropped soon(ish) anyways.

Given we only have one filesytem that is submitted in patch form, I
think people are making a lot of noise over nothing :)

thanks,

greg k-h
