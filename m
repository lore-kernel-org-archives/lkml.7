Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EF91C43219
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 17:51:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E14E2084F
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 17:51:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556214709;
	bh=oyOWu+gC2jD8g/jocO0s2HDhULDxKDX+gEmdpkqcy08=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=uzpI3Hfeoa6uIXt3kZ5V7YBuD9PCM23DLwgNhutIfgXEoXhtKawc/S/C529V34y4X
	 8vYu3+8zQs6RpGUMMVkYWq/0zUWgsu/SY0s4iN0ZV2RAIXVVH+t3rmmtq0pGZVB9Vc
	 ay5pBsCSbqnfA2DsMc2YdFFEyhEX9Y83exrDU7lY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726802AbfDYRvr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 13:51:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:55802 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726124AbfDYRvq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 13:51:46 -0400
Received: from localhost (62-193-50-229.as16211.net [62.193.50.229])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 372AC2084F;
        Thu, 25 Apr 2019 17:51:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556214706;
        bh=oyOWu+gC2jD8g/jocO0s2HDhULDxKDX+gEmdpkqcy08=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=R+dEc7K0fs32wWSkPUUcRnH3h9FrYbI9Y74fbVKO8DVEi9gpp37EsmCFejGSWNPJh
         7TQzp7xaDZ+r/RncNL5i5+/ivIvnm7jinKaDeceLT3KhaIiTgED3Gywz/ln+OI/IxG
         bqlbYcyTn30JC7Yf4ud6M3aLgc3NGzUt9BNIFfSA=
Date:   Thu, 25 Apr 2019 19:51:26 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Chanwoo Choi <cw00.choi@samsung.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Chanwoo Choi (chanwoo@kernel.org)" <chanwoo@kernel.org>,
        =?utf-8?B?7ZWo66qF7KO8?= <myungjoo.ham@samsung.com>
Subject: Re: [GIT PULL] extcon next for v5.2
Message-ID: <20190425175126.GA25967@kroah.com>
References: <CGME20190423055704epcas1p3698d02b077f2e75da943525437363840@epcas1p3.samsung.com>
 <b3ff314f-194a-a8e1-b4f9-ef281cd9e577@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b3ff314f-194a-a8e1-b4f9-ef281cd9e577@samsung.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 23, 2019 at 02:58:09PM +0900, Chanwoo Choi wrote:
> Dear Greg,
> 
> This is extcon-next pull request for v5.2. I add detailed description of
> this pull request on below. Please pull extcon with following updates.
> 
> [Detailed description for this pull request]
> 1. Add new extcon-intel-mrfld.c extcon provider driver
> - On Intel Merrifield the Basin Cove PMIC provides a feature to detect
> the USB connection type. This driver utilizes the feature in order
> to support the USB dual role detection.
> 
> 2. Update the extcon provider drivers
> - For extcon-intel-cht-wc.c, make charger detection co-existed
>   with OTG host mode and enable external charger.
> - For intel extcon driver, add common header file (extcon-intel.h)
>   in order to remove the duplicate definitions.
> - For extcon-arizonal.c, disable microphone detection on driver removal.
> 
> 3.
> - Edit comment of extcon_unregister_notifer() to fix a build warning
> - Add CONFIG_ACPI dependency to Kconfig to fix a build error for extcon-axp.c
> 
> Best Regards,
> Chanwoo Choi
> 
> 
> The following changes since commit 86baf800de84eb89615c138d368b14bff5ee7d8a:
> 
>   extcon: ptn5150: fix COMPILE_TEST dependencies (2019-04-05 10:08:37 +0900)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/extcon.git tags/extcon-next-for-5.2

Pulled and pushed out, thanks.

greg k-h
