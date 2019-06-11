Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 298D5C4646D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 17:12:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02D9C2086D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 17:12:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zhysk8g9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405706AbfFKRMb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 13:12:31 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:43442 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390558AbfFKRMb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 13:12:31 -0400
Received: by mail-lj1-f196.google.com with SMTP id 16so12397627ljv.10
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2019 10:12:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7Q2nXR/ekojOiR5sUmGvhEuyK8eOjK9a1qApppPCPRg=;
        b=zhysk8g9oycnSRizjjZnI0jfjQCWmf2JEqmkIJh44iZxVezIYiDydXYIr/Mk5h7exc
         +pMHHnZnXQr8ZrwCHWC5F2itb0Oo+2e6MHKvvrzCcEDYxm5gIiarph2KXZLUXdIS8cUY
         XYBU5xIEZWYVTkapZr0ePm0mCPJyPtpiZUHUqrZ79Auh/TN4eFZb1BcB64PiCSeV3MsY
         XbnaP12y64gK+wdZpnjrV4yCAWJ6chUCBFd1MRZJnqnJkgVyn097HXOa0aKALlh8qnex
         cPyDEkApIUzTKjyjoKu+1tDN1ywWz2oWMHbN9ViGt4oawbVRwVd0TsWhfXBUeF/t8Enp
         Anqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7Q2nXR/ekojOiR5sUmGvhEuyK8eOjK9a1qApppPCPRg=;
        b=H2nO6B4LrDTzQF/ANZ/CJv5KRw4MNsUvZP0qV/LUwTsgQN+MnWV4mr+q4WdkS+MwFQ
         0O13c9ngT2+Apjq8wMvDhio+kALhwrhxUelh41Bl/N7nUMr/UNmaM5jMdYsYB4+MSnUR
         xryvR4lOJQoGWpF/Y2wdgpN6DGDvnEZYj43u8Tf3eK16SPLvcDQj2516jGFmWJLv2RC4
         OzG4cK5eb0gQnTjc6eHQiGAmbe+F4GmgKZm6hQ4iywTLIfBovT5M0GUjOWp9EifsRxAH
         /EeSSfbvn6IlzI5CyCPTMJMsdquT0bITGz+PbVer/OJfALU7jgCQzmj8DbP5Wwzg7SM0
         CoHA==
X-Gm-Message-State: APjAAAVMporWNpiuEinrq94t3qkoBIxpftZXVqF6WHl/rVYv3V6gk+/4
        FQV2ahb4EsweTQ5Joko+tmtvbg==
X-Google-Smtp-Source: APXvYqyTDU5uNwj4l7WRFPn54JbScsVPEuL5kCcH7Zg+fqtdWCZNd+7BOg/sjeTJ2sUPnyxzH44Wrg==
X-Received: by 2002:a2e:7f0d:: with SMTP id a13mr26316612ljd.70.1560273148928;
        Tue, 11 Jun 2019 10:12:28 -0700 (PDT)
Received: from centauri.ideon.se ([85.235.10.227])
        by smtp.gmail.com with ESMTPSA id t3sm2592745lfk.59.2019.06.11.10.12.27
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 11 Jun 2019 10:12:27 -0700 (PDT)
Date:   Tue, 11 Jun 2019 19:12:25 +0200
From:   Niklas Cassel <niklas.cassel@linaro.org>
To:     Paolo Pisati <p.pisati@gmail.com>
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: msm8996: qcom-qmp: apq8096-db820c fails to boot, reset back to
 fastboot and locks up
Message-ID: <20190611171225.GA21992@centauri.ideon.se>
References: <20190610134401.GA12964@harukaze>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190610134401.GA12964@harukaze>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 10, 2019 at 03:44:01PM +0200, Paolo Pisati wrote:
> From time to time, my apq8096-db820c fails to boot to userspace, reset back to
> fastboot and locks up: to easily reproduce the issue, i'm boot looping using a
> cron job with a 1 min reboot entry on the board while leaving a "while 1; do
> fastboot boot boot.img; done" on the host pc.
> 
> The issue is present in mainline up to 5.2-rc4, using defconfig and:
> 
> CONFIG_SCSI_UFS_QCOM=y
> CONFIG_PHY_QCOM_QMP=y
> CONFIG_PHY_QCOM_UFS=y
> 
> but was present in previous releases too (e.g. 4.14., 4.19, etc qcom-lt or
> mainline), where it's even easier to reproduce (e.g. takes way less reboots to
> trigger it).

Hello Paolo,

I have a guess of what is going on.
db820c has 3 PCIe controllers,
that shares a singe QMP block (that has clocks, regulators, and resets).
The QMP block has 3 PCIe PHYs, that have their own clocks and resets.

> 
> These are the last lines printed out:
> ...
> [    7.407209] qcom-qmp-phy 34000.phy: Registered Qcom-QMP phy
> [    7.448058] qcom-qmp-phy 7410000.phy: Registered Qcom-QMP phy
> [    7.461859] ufs_qcom_phy_qmp_14nm 627000.phy: invalid resource
> [    7.535434] qcom-qmp-phy 34000.phy: phy common block init timed-out

^^ here the phy_init() called from pcie-qcom.c
which ends up to a call to qcom_qmp_phy_enable()

which has this code:

        ret = qcom_qmp_phy_com_init(qphy);
        if (ret)
                return ret;

qcom_qmp_phy_com_init() has this code:

        if (qmp->init_count++) {
                mutex_unlock(&qmp->phy_mutex);
                return 0;
        }

qcom_qmp_phy_com_init() later fails,
since the common block init time out, so the qmp driver
disables clocks, asserts reset, and disables regulators


> [    7.538596] phy phy-34000.phy.0: phy init failed --> -110
> [    7.550891] qcom-pcie: probe of 600000.pcie failed with error -110

^^ here the first PCIe controller instance fails to probe

> [    7.619008] qcom-pcie 608000.pcie: 608000.pcie supply vddpe-3v3 not found,
> using dummy regulator

^^ here the second PCIe controller is probed.

it will call phy_init()

which will again call qcom_qmp_phy_enable() which will call
qcom_qmp_phy_com_init()

where this code:

        if (qmp->init_count++) {
                mutex_unlock(&qmp->phy_mutex);
                return 0;
        }

now will return 0,

so clocks will never be enabled, resets never deasserted, regulators
never enabled.

since qcom_qmp_phy_com_init() returns success in this case,
qcom_qmp_phy_enable() will try to continue with the init,
and writes to disabled hardware is usually not a good idea.

I think the proper fix for this is:

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp.c b/drivers/phy/qualcomm/phy-qcom-qmp.c
index cd91b4179b10..22352e3b0ec5 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp.c
@@ -1490,7 +1490,7 @@ static int qcom_qmp_phy_enable(struct phy *phy)
 
        ret = qcom_qmp_phy_com_init(qphy);
        if (ret)
-               return ret;
+               goto err_lane_rst;
 
        if (cfg->has_lane_rst) {
                ret = reset_control_deassert(qphy->lane_rst);



Kind regards,
Niklas

> 
> Log Type: B - Since Boot(Power On Reset),  D - Delta,  S - Statistic
> S - QC_IMAGE_VERSION_STRING=BOOT.XF.1.0-00301
> S - IMAGE_VARIANT_STRING=M8996LAB
> S - OEM_IMAGE_VERSION_STRING=crm-ubuntu68
> S - Boot Interface: UFS
> S - Secure Boot: Off
> ...
> 
> Full boot here: https://pastebin.ubuntu.com/p/rtjVrD3yzk/
> 
> Any idea what is going on? Am i doing something wrong?
> -- 
> bye,
> p.
