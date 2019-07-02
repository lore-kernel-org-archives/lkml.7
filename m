Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB64AC06510
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 14:21:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3D812063F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 14:21:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mhch/ZQn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727091AbfGBOVP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 10:21:15 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43767 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726803AbfGBOVO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 10:21:14 -0400
Received: by mail-wr1-f67.google.com with SMTP id p13so18029164wru.10
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2019 07:21:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0T0bkaVX+wFo4N32YlZXYNiR/7O5n98pISnD8ARqYHs=;
        b=mhch/ZQnDFaRuGeaeQn210tNIkyw81M4xjEEW5OVV26kZDvcSBUufpYKMrDOEZxHJO
         GqQcS9gGECO8hlAQeW97kI2Kce+6NXwlhJhFzsENIc/OLCkDS8MzgjQN5iMTkLHsbHPk
         anWBdlZ/KHPWZbiU9klzy8BSsVT6Kqb/SrEsLOpv9h9pCM3fz2/OozBPMda1EUvx6eCY
         J5C+bnh1K4JBvEm7z+G0gXRoKjakDfOaguWklBmsMHM/hUWgaaeJNAPdSKf/IuTx4yj1
         nh/60lT3fPpBhFByk8ZkRp54DlbCil76U3T3qqQPONViDjMfRCHNY8gJCpm5nLNwN3Tc
         nPjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0T0bkaVX+wFo4N32YlZXYNiR/7O5n98pISnD8ARqYHs=;
        b=oNMEIdRQI6p9Z+LKaug7unuVMWUc9ra+ObUCk/f4xrU2GHOIDGRqfpyEavbj6dhCqz
         q6Gv83b5CD+014GiBeaBxLfq/xCKnL5HaYR13rnD405kPZ/B7s2podEWUdPI5BZIwrAx
         CmzRp6Hdtfp0y0OQl4ZWnN4jhItg7V2qzhat5G2wkVXjqgWbD3NNlfgqc9SYtsymuOBA
         2NwwTbR0gMMbwWn1B7EelxzXuHXN/TzJI2QnKhZyzOL1pfiML67e+8TpFypxhWKW9bvj
         KYIb7mcodG8I0qCSXVTnlYrXLMnDWtD3EmM/In5D5Cjvlo3Yr967vjr7NA4WuCwKZoW7
         7DGw==
X-Gm-Message-State: APjAAAUdM5xu2eO9YAIAVRPbukQA2pwYIb9eHo10JvB0w4agD2wmh8Zl
        IYOLdoF748CMz4F6SCgdRQsLmw==
X-Google-Smtp-Source: APXvYqyCI2efyMIR3muhRyuBtQrsbaQPkg/M8stSquNHreZP+SaS6imoe173p76G1uUfDIl8YwHsFw==
X-Received: by 2002:a5d:68c7:: with SMTP id p7mr662423wrw.349.1562077273050;
        Tue, 02 Jul 2019 07:21:13 -0700 (PDT)
Received: from apalos (athedsl-428434.home.otenet.gr. [79.131.225.144])
        by smtp.gmail.com with ESMTPSA id r6sm3176635wmh.11.2019.07.02.07.21.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Jul 2019 07:21:12 -0700 (PDT)
Date:   Tue, 2 Jul 2019 17:21:09 +0300
From:   Ilias Apalodimas <ilias.apalodimas@linaro.org>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     Sasha Levin <sashal@kernel.org>, peterhuewe@gmx.de, jgg@ziepe.ca,
        corbet@lwn.net, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-kernel@microsoft.com, thiruan@microsoft.com,
        bryankel@microsoft.com, tee-dev@lists.linaro.org,
        sumit.garg@linaro.org, rdunlap@infradead.org
Subject: Re: [PATCH v7 1/2] fTPM: firmware TPM running in TEE
Message-ID: <20190702142109.GA32069@apalos>
References: <20190625201341.15865-1-sashal@kernel.org>
 <20190625201341.15865-2-sashal@kernel.org>
 <673dd30d03e8ed9825bb46ef21b2efef015f6f2a.camel@linux.intel.com>
 <20190626235653.GL7898@sasha-vm>
 <b688e845ccbe011c54b10043fbc3c0de8f0befc2.camel@linux.intel.com>
 <20190627133004.GA3757@apalos>
 <0893dc429d4c3f3b52d423f9e61c08a5012a7519.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0893dc429d4c3f3b52d423f9e61c08a5012a7519.camel@linux.intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> On Thu, 2019-06-27 at 16:30 +0300, Ilias Apalodimas wrote:
> > is really useful. I don't have hardware to test this at the moment, but once i
> > get it, i'll give it a spin.
> 
> Thank you for responding, really appreciate it.
> 
No worries
> Please note, however, that I already did my v5.3 PR so there is a lot of
> time to give it a spin. In all cases, we will find a way to put this to
> my v5.4 PR. I don't see any reason why not.
> 
> As soon as the cosmetic stuff is fixed that I remarked in v7 I'm ready
> to take this to my tree and after that soonish make it available on
> linux-next.
I managed to do some quick testing in QEMU. 
Everything works fine when i build this as a module (using IBM's TPM 2.0 TSS)

- As module
# insmod /lib/modules/5.2.0-rc1/kernel/drivers/char/tpm/tpm_ftpm_tee.ko
# getrandom -by 8
randomBytes length 8
23 b9 3d c3 90 13 d9 6b 

- Built-in
# dmesg | grep optee
ftpm-tee firmware:optee: ftpm_tee_probe:tee_client_open_session failed,
err=ffff0008
ftpm-tee: probe of firmware:optee failed with error -22
# getrandom -by 8
random: fast init done
urandom_read: 2 callbacks suppressed
random: getrandom: uninitialized urandom read (32 bytes read)
TSS_Dev_Open: Error opening /dev/tpm0
getrandom: failed, rc 000b0008
TSS_RC_NO_CONNECTION - Failure connecting to lower layer

Am i missing anything?

Thanks
/Ilias
