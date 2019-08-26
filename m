Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B00A2C3A59E
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 09:46:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81AF222D6D
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 09:46:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566812798;
	bh=nzPxJJoVZQWfnWhnchm+tFSlQxcNe6Q5yoB5jvZAjXQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=JPkuxcP2mZf9IVS4fX6QRzuRJjhWPQSInaxvE7aWNkgjytxcNvhhYfUjQjnKFpf5X
	 xUlkjUqLKIl7SBu5XXiQkvMpJ3tKLruvtLRZKP5zC7nUkYlakmL8AgmVr6Yjx3+UsX
	 pHNBhaVKo2pRfGDxTIhLLPWK69MSETO42dtGgyLk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731041AbfHZJqh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 05:46:37 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43100 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726635AbfHZJqg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 05:46:36 -0400
Received: by mail-wr1-f67.google.com with SMTP id y8so14613928wrn.10
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2019 02:46:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=EtvI0xSRTbvxcXYic0FI92pUdW0pAG1dUcejVq6p/a0=;
        b=nMMgdW90B6mREM94Wnjb6J/NtiEXMgnCYkqIsTeG8ZVxudQTCRimYMKKjeA41Qbx+z
         NDyTrVRAruJz8uSRiw4ZpZ2xLlCBIqC9f8cWCdI5uWC2FUeYqS/78HqGWVjaW+m0zLyB
         teFfK1hIIYuBs8tjfSAXhYU7bigkvugQdPVj1dv41vHylKJ/0h6JpjfWvH8RVcREukUA
         JC+Z0x/SFT9ZuCa8+at17UEo5ygDsJZR1BSULMOM1nCokd9L6TkfwX27OuFXZr272Bvc
         x6sILs7fWGk3OIk//SSSWd17sJehPm5x6XqMtfTSTRDhqwjsHCRj/rZcorvKHzmz87na
         Ctew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=EtvI0xSRTbvxcXYic0FI92pUdW0pAG1dUcejVq6p/a0=;
        b=CugjLfRlETneFvVE0TUKaA9rxELZVgVHY9qOig9jucOWq8/ZOb50S9u46bqTx1SpNo
         uZzd1RUFtXJBKV2wP4RUoXd9tn0hLoykyAXabHxfjnCzQVV7wQRO38x1Q0MV/c1YVJZU
         IbxBQd2wWjgQjtQiXeXu/RAYFrkIIchK9NMXkTPsOefziBCGC7OfOr6YhFpuoBlBOPXM
         DB1Z7PtdDRloxqvn7W7JiOSFzuBzRumV37HRJgccY954d1Xl7yxb4JsOEAF/LzkhMLzU
         /Bb2oQTHhb9hZ+c1/j9zYAyNof9ZpFkHp+CSVp1EXJ9qU/8+vrt9NY2a8kD/6eeUux+g
         liJA==
X-Gm-Message-State: APjAAAWusufya1OQGhx8qYa3PqvosbR3zTRv/YR9e55fzbiI7OuaV0Cc
        EbXgZqjZwDrtl34Fo/I5r+A=
X-Google-Smtp-Source: APXvYqwO6eMiQmbEfkWXa6AlEtTLxRUvX6V8tlSua2Fm7tbdYa00tX8CJiZANRnipEKZVd3CuLsJfA==
X-Received: by 2002:a5d:4101:: with SMTP id l1mr22205654wrp.202.1566812794994;
        Mon, 26 Aug 2019 02:46:34 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id 2sm15457478wmz.16.2019.08.26.02.46.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2019 02:46:34 -0700 (PDT)
Date:   Mon, 26 Aug 2019 11:46:32 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Dave Hansen <dave.hansen@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tony Luck <tony.luck@intel.com>
Subject: Re: [PATCH 4/5] x86/intel: Aggregate microserver naming
Message-ID: <20190826094632.GA65121@gmail.com>
References: <20190822102306.109718810@infradead.org>
 <20190822102411.337145504@infradead.org>
 <20190826092750.GA56543@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190826092750.GA56543@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Ingo Molnar <mingo@kernel.org> wrote:

>  arch/x86/kernel/cpu/common.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Plus this too:

---
 drivers/edac/sb_edac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/edac/sb_edac.c b/drivers/edac/sb_edac.c
index 37746b045e18..f743502ca9b7 100644
--- a/drivers/edac/sb_edac.c
+++ b/drivers/edac/sb_edac.c
@@ -3429,7 +3429,7 @@ static const struct x86_cpu_id sbridge_cpuids[] = {
 	INTEL_CPU_FAM6(IVYBRIDGE_X,	  pci_dev_descr_ibridge_table),
 	INTEL_CPU_FAM6(HASWELL_X,	  pci_dev_descr_haswell_table),
 	INTEL_CPU_FAM6(BROADWELL_X,	  pci_dev_descr_broadwell_table),
-	INTEL_CPU_FAM6(BROADWELL_XEON_D,  pci_dev_descr_broadwell_table),
+	INTEL_CPU_FAM6(BROADWELL_D,	  pci_dev_descr_broadwell_table),
 	INTEL_CPU_FAM6(XEON_PHI_KNL,	  pci_dev_descr_knl_table),
 	INTEL_CPU_FAM6(XEON_PHI_KNM,	  pci_dev_descr_knl_table),
 	{ }

