Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A635ACA9EB9
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 00:23:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D12320650
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 00:23:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PWMr/nMY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733121AbfJWAXv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 20:23:51 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:33534 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732822AbfJWAXu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 20:23:50 -0400
Received: by mail-pg1-f193.google.com with SMTP id u23so312634pgo.0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2019 17:23:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=/rPZ4HhwO2Y5OxYPZvTpAmk/8khmnCdcuj1jKDBcIYI=;
        b=PWMr/nMYg+m7WtNCPLVizhxiu8gyfLZI0qwKU6Yqp4oFhAsoLzwWin4tCq7I2oHIei
         iAuxmHtpkNw44YwnJVo1QUoaReR9DmkDLXMTJedbn0+8dhb6RU6C+u9Ltmj4XbZ8fqWM
         xP2Jj51dT1JuQLgl25G3zBtz6CXYBhEBscM0PODXuxtEddF9t/J3rU0w7Jp0y5yquS7/
         5dX4qJZp8G15mW7nLthkGTyUcF3X+UYcgilTiWO9BvErNmqsj6sVk8JMFJL1eIPDd/f6
         bIhlrg0o23AUNMSfTePJemTx+FFcPxq7SWdJIDlsC17QN2bhA1rtFuwcGr9ig5LnNbOf
         o4dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=/rPZ4HhwO2Y5OxYPZvTpAmk/8khmnCdcuj1jKDBcIYI=;
        b=uQCaEG0qV5zloDFP4/Y8qJagnlHFmK4H3Y1dhWJoQUakvrPYdQjId3WADNeWvwOqK6
         R8ziHmDCIx0Qdv1vHdQOw2PFGJqRoQ1uWGsp3wWTVBC1uo9XKlPaCBHmrpJ0/apM2jE0
         MzjpaN13Lgws9Pgz0mu1ykj6QcGfU/G2yIyjd5JjZBgLsUEEXVmr1T0itDzZp2WVFDnD
         0Pgh8wFe2MxMGcyfODutkfh0G+g3VFSOc6crYQzHv8n+tB0jSgB44mOz+IN6DeEn1231
         QLppw1IQG5BUpPJdyFHDt0UpK9oHgpdXHAvWArfsMGC3v6PSydocRdRg6TchZwUVjPSl
         5B6w==
X-Gm-Message-State: APjAAAXI502MLMymbsIOtAxllsdfiShd+1BRLKkBnqLg3bEw2R555DYs
        +Dz4xFUW/nUArn06smeZ/oHNj27pUxw=
X-Google-Smtp-Source: APXvYqz+Z9nLdGje/5/GaGDSa9/q6bNKjeojhvbDbY03xj4oOhikScXlxlbbMaHu4V4ZTUwDYQLl8Q==
X-Received: by 2002:a17:90a:eace:: with SMTP id ev14mr8128545pjb.57.1571790228097;
        Tue, 22 Oct 2019 17:23:48 -0700 (PDT)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id d7sm8201906pgv.6.2019.10.22.17.23.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2019 17:23:47 -0700 (PDT)
Date:   Tue, 22 Oct 2019 17:23:46 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     "Singh, Brijesh" <brijesh.singh@amd.com>
cc:     "Kalra, Ashish" <Ashish.Kalra@amd.com>,
        "Lendacky, Thomas" <Thomas.Lendacky@amd.com>,
        "Hook, Gary" <Gary.Hook@amd.com>,
        "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "allison@lohutok.net" <allison@lohutok.net>,
        "info@metux.net" <info@metux.net>,
        "yamada.masahiro@socionext.com" <yamada.masahiro@socionext.com>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>
Subject: Re: [PATCH] crypto: ccp - Retry SEV INIT command in case of integrity
 check failure.
In-Reply-To: <cfc975bb-d520-82a4-6fbe-40d78ce2e822@amd.com>
Message-ID: <alpine.DEB.2.21.1910221723220.126424@chino.kir.corp.google.com>
References: <20191017223459.64281-1-Ashish.Kalra@amd.com> <alpine.DEB.2.21.1910190156210.140416@chino.kir.corp.google.com> <29887804-ecab-ae83-8d3f-52ea83e44b4e@amd.com> <alpine.DEB.2.21.1910211754550.152056@chino.kir.corp.google.com>
 <cfc975bb-d520-82a4-6fbe-40d78ce2e822@amd.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Oct 2019, Singh, Brijesh wrote:

> >>>> From: Ashish Kalra <ashish.kalra@amd.com>
> >>>>
> >>>> SEV INIT command loads the SEV related persistent data from NVS
> >>>> and initializes the platform context. The firmware validates the
> >>>> persistent state. If validation fails, the firmware will reset
> >>>> the persisent state and return an integrity check failure status.
> >>>>
> >>>> At this point, a subsequent INIT command should succeed, so retry
> >>>> the command. The INIT command retry is only done during driver
> >>>> initialization.
> >>>>
> >>>> Additional enums along with SEV_RET_SECURE_DATA_INVALID are added
> >>>> to sev_ret_code to maintain continuity and relevance of enum values.
> >>>>
> >>>> Signed-off-by: Ashish Kalra <ashish.kalra@amd.com>
> >>>> ---
> >>>>    drivers/crypto/ccp/psp-dev.c | 12 ++++++++++++
> >>>>    include/uapi/linux/psp-sev.h |  3 +++
> >>>>    2 files changed, 15 insertions(+)
> >>>>
> >>>> diff --git a/drivers/crypto/ccp/psp-dev.c b/drivers/crypto/ccp/psp-dev.c
> >>>> index 6b17d179ef8a..f9318d4482f2 100644
> >>>> --- a/drivers/crypto/ccp/psp-dev.c
> >>>> +++ b/drivers/crypto/ccp/psp-dev.c
> >>>> @@ -1064,6 +1064,18 @@ void psp_pci_init(void)
> >>>>    
> >>>>    	/* Initialize the platform */
> >>>>    	rc = sev_platform_init(&error);
> >>>> +	if (rc && (error == SEV_RET_SECURE_DATA_INVALID)) {
> >>>> +		/*
> >>>> +		 * INIT command returned an integrity check failure
> >>>> +		 * status code, meaning that firmware load and
> >>>> +		 * validation of SEV related persistent data has
> >>>> +		 * failed and persistent state has been erased.
> >>>> +		 * Retrying INIT command here should succeed.
> >>>> +		 */
> >>>> +		dev_dbg(sp->dev, "SEV: retrying INIT command");
> >>>> +		rc = sev_platform_init(&error);
> >>>> +	}
> >>>> +
> >>>>    	if (rc) {
> >>>>    		dev_err(sp->dev, "SEV: failed to INIT error %#x\n", error);
> >>>>    		return;
> >>>
> >>> Curious why this isn't done in __sev_platform_init_locked() since
> >>> sev_platform_init() can be called when loading the kvm module and the same
> >>> init failure can happen that way.
> >>>
> >>
> >> The FW initialization (aka PLATFORM_INIT) is called in the following
> >> code paths:
> >>
> >> 1. During system boot up
> >>
> >> and
> >>
> >> 2. After the platform reset command is issued
> >>
> >> The patch takes care of #1. Based on the spec, platform reset command
> >> should erase the persistent data and the PLATFORM_INIT should *not* fail
> >> with SEV_RET_SECURE_DATA_INVALID error code. So, I am not able to see
> >> any  strong reason to move the retry code in
> >> __sev_platform_init_locked().
> >>
> > 
> > Hmm, is the sev_platform_init() call in sev_guest_init() intended to do
> > SEV_CMD_INIT only after platform reset?  I was under the impression it was
> > done in case any previous init failed.
> > 
> 
> 
> The PLATFORM_INIT command is allowed only when FW is in UINIT state. On
> boot, the FW will be in UNINIT state and similarly after the platform 
> reset command the FW goes back to UNINIT state.
> 
> The __sev_platform_init_locked() checks the FW state before issuing the
> command, if FW is already in INIT state then it returns immediately.
> 

Ah, got it, thanks.

Acked-by: David Rientjes <rientjes@google.com>
