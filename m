Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84C20C3A59E
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 09:48:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55A8A2070B
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 09:48:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566812919;
	bh=mP+NN5Lt0RYFxbwvJWR809/lWCR+/OkLhRm2A8+uVkE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=gKRGRLUywjn8RZgJWf0MSHQLWa1HgzBH1E6vGKRaFV9owEb9yn04l5dJiKjAFc25O
	 tSSvUxn3kx9qq9+6BH2/NVV3hxDJ+1Njm2JZpriG3NNKvHCuPDAYh//Rzs3NmOe9yU
	 /LxtDLA/hghBs6hPPJ84v7eThA37rTSQ8TpNzufQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731063AbfHZJsi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 05:48:38 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:40013 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729922AbfHZJsh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 05:48:37 -0400
Received: by mail-wm1-f65.google.com with SMTP id c5so14978330wmb.5
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2019 02:48:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=tlLXO+Wmk0gYIcGIx/qZzyKAP+c7x5IBFJLMyNNgig8=;
        b=hJFcqFC03mrFFin8zRYLF0qJKGObhB+m5kOMCF345enXS1UDHtiDYp91DyvkIzrdqC
         TT/xAJ/zzQJOqDU1QMPNiuK4XOenm23BcMu75htjRqoiOytoW7O+Ig9/RUsO48XzJx40
         OXX6WfSgC5SDku3CmolioYQ0li2SPIMA3OkQtxpCUmboo4D3/O1anes929lYlMJoFi+i
         Xy5Gsk0DAwiuzCcDG16zyQt7iahyLld8jPXi9Yu0cySjz+mwaD2baXsdz31SONLce3aO
         utXG1PL6fnrnCJxyMhmNxi67uBxht2OfJoSAu+nuz3MP3vCl9rU5/bCMd5jqCFcP3nyL
         vFhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=tlLXO+Wmk0gYIcGIx/qZzyKAP+c7x5IBFJLMyNNgig8=;
        b=SXwATmXoWnYB4g/3S1efvmkBKHly5OrXk3Sf4J8n4kTBVQ8mO8eftbKLt2JGT28kag
         e4/c4OwKTjjrLnH1Q+SeslMJcmp1SH5FjmySSkWZgaP/h2swluynUNWzQMOvADPn+MPA
         tqbXE9nw5tF4DGrS30t5nfy8Tue0oWv7hvo7bteyYclHcN2gamngURH8dm3EOFX7p6Y5
         YtFgXYxuF5UCUSQ98o69Unzwb3aPoyFpqZzzbhkGWtmwpZhOhgci7XD8q+Un5mpgVQmL
         4jEJs/IyKJ6QKfQB/lMAi9j3UgwXTwost6j2oHVoWgZVwpZELrelagoHfsxjtc41Pp/5
         jRsw==
X-Gm-Message-State: APjAAAVSbgTLVDOo0WHNjRmUIshCb7OK8/QbsCmzbZyI36KmCpL4C+aG
        psH6pCxPGnUceX+tduybmGc=
X-Google-Smtp-Source: APXvYqyO5HARMd26cjsKobpwkE/ylTjOVyVElyzkivtILUSVptyVAYDU4EDmJgg5fmmN05jXgsm9GA==
X-Received: by 2002:a7b:ca54:: with SMTP id m20mr20895699wml.102.1566812916008;
        Mon, 26 Aug 2019 02:48:36 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id 39sm35395812wrc.45.2019.08.26.02.48.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2019 02:48:35 -0700 (PDT)
Date:   Mon, 26 Aug 2019 11:48:33 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Dave Hansen <dave.hansen@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tony Luck <tony.luck@intel.com>
Subject: Re: [PATCH 4/5] x86/intel: Aggregate microserver naming
Message-ID: <20190826094833.GA100070@gmail.com>
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


Plus re-running your scripts gave the final missing piece:

Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 tools/power/x86/turbostat/turbostat.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 91d869343a16..6eef0cee6d75 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -3405,9 +3405,9 @@ int has_config_tdp(unsigned int family, unsigned int model)
 	case INTEL_FAM6_IVYBRIDGE:	/* IVB */
 	case INTEL_FAM6_HASWELL:	/* HSW */
 	case INTEL_FAM6_HASWELL_X:	/* HSX */
-	case INTEL_FAM6_HASWELL_GT3E:	/* HSW */
+	case INTEL_FAM6_HASWELL_G:	/* HSW */
 	case INTEL_FAM6_BROADWELL:	/* BDW */
-	case INTEL_FAM6_BROADWELL_GT3E:	/* BDW */
+	case INTEL_FAM6_BROADWELL_G:	/* BDW */
 	case INTEL_FAM6_BROADWELL_X:	/* BDX */
 	case INTEL_FAM6_SKYLAKE_L:	/* SKL */
 	case INTEL_FAM6_CANNONLAKE_L:	/* CNL */

