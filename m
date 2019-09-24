Return-Path: <SRS0=YpA9=XT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 004AEC432C2
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 19:39:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1DAA214AF
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 19:39:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Diz/MIln"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439567AbfIXTj7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Sep 2019 15:39:59 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:40721 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730834AbfIXTj6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 15:39:58 -0400
Received: by mail-qk1-f193.google.com with SMTP id y144so3037799qkb.7
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2019 12:39:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Hst94Q/uEIj99uJShhCkFvpZkrB3EQ8x2MXnvyPaPyo=;
        b=Diz/MIln0Ci08QUy8q8XscghMGLcVtTzXZc1saNGpsT2ACsPNUtSh5RKA9bEQq4pNC
         P8r8FpvOSm5fcF5qPlFncIUWnZ+WNNRq9WxL6rjl5Lq8cNmeyOrjVsss6xzSdWCn1xgQ
         +LPSiAKO8/1h0HGqviMaCVbAo87xKtIG5KLoXWXwV/Bf/ZCkKtp9VBvpPk90ehdoq1po
         TcJWuMYG6Nim85vIBQ45B3LOKNnEN5VC7l1avPT/z0oGMI5PaSpUDArQoRX55iR+wY2x
         AVgvRnT0SPpHD8DNPqVTCcnhHd0LY6igYREMWEiwOvSJMPwGcoXgg1JrzjWbUVHtsRMw
         PIZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Hst94Q/uEIj99uJShhCkFvpZkrB3EQ8x2MXnvyPaPyo=;
        b=kos/ZdUTUT9LDf+QT7axzWJ4ak9gDTORTbNqwOmF0BPC7/5Tx//rozcH+yxqsQcmMc
         3fvU+kza464JYTL9W0Uq3tRVzUCCZzlQmm244QH/E1hydhB+v33+bZ93iixPF7l2gmZZ
         wR/S72FSIjbpsjaFSCHRT4UA+AMpLj89qzNot4dv2WHs2JLUXje/0S3ZwRICejYfOLwg
         NrkWoeBwIb/aaudBjxQZ4DLDJS1kOuLh+Q9tETkwHZ/khEfuwjLzUY76f0/EuVhxiVXd
         5Vewu0jrG8aPDsJbdtOGYwHBZ7GDG0L8dJDF6sN4uBp0vk0pFnGNKTtW/AdMEMSgonPK
         VhjQ==
X-Gm-Message-State: APjAAAU9U/3YvfR/eeqfPg+VaxVNf1arwOm+e1OpiY7F8oosEm68JaXf
        ki+7eGeZS1Xn3jDgxb1+6kg=
X-Google-Smtp-Source: APXvYqxl9tF8OblJkzVkfY13yJw2V3kGQ7Rrjw4aZlGwnVdasnw9sd3aXvwhsSFJ9bxdXG9Ra+JGFg==
X-Received: by 2002:a37:660e:: with SMTP id a14mr4101995qkc.481.1569353997605;
        Tue, 24 Sep 2019 12:39:57 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([177.195.210.60])
        by smtp.gmail.com with ESMTPSA id v13sm1229040qtp.61.2019.09.24.12.39.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Sep 2019 12:39:57 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 9B0B141105; Tue, 24 Sep 2019 16:39:46 -0300 (-03)
Date:   Tue, 24 Sep 2019 16:39:46 -0300
To:     Mamatha Inamdar <mamatha4@linux.vnet.ibm.com>
Cc:     linux-kernel@vger.kernel.org, ravi.bangoria@linux.ibm.com,
        maddy@linux.vnet.ibm.com, peterz@infradead.org, mpe@ellerman.id.au,
        alexander.shishkin@linux.intel.com, mingo@redhat.com,
        namhyung@kernel.org, jolsa@redhat.com
Subject: Re: [PATCH]perf vendor events:Remove P8 HW events which are not
 supported
Message-ID: <20190924193946.GB20773@kernel.org>
References: <20190909065624.11956.3992.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190909065624.11956.3992.stgit@localhost.localdomain>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Sep 09, 2019 at 12:33:33PM +0530, Mamatha Inamdar escreveu:
> This patch is to remove following hardware events
> from JSON file which are not supported on POWER8.
> 
> pm_l3_p0_grp_pump
> pm_l3_p0_lco_data
> pm_l3_p0_lco_no_data
> pm_l3_p0_lco_rty

Thanks, applied.

- Arnaldo
 
> Fixes: c3b4d5c4afb0 ("perf vendor events: Remove P8 HW events which are not supported")
> Note: Unfortunately power8 event list is not publicly available.
> Signed-off-by: Mamatha Inamdar <mamatha4@linux.vnet.ibm.com>
> Acked-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
> ---
>  .../perf/pmu-events/arch/powerpc/power8/other.json |   24 --------------------
>  1 file changed, 24 deletions(-)
> 
> diff --git a/tools/perf/pmu-events/arch/powerpc/power8/other.json b/tools/perf/pmu-events/arch/powerpc/power8/other.json
> index 9dc2f6b7..b2a3df0 100644
> --- a/tools/perf/pmu-events/arch/powerpc/power8/other.json
> +++ b/tools/perf/pmu-events/arch/powerpc/power8/other.json
> @@ -1776,30 +1776,6 @@
>      "PublicDescription": ""
>    },
>    {,
> -    "EventCode": "0xa29084",
> -    "EventName": "PM_L3_P0_GRP_PUMP",
> -    "BriefDescription": "L3 pf sent with grp scope port 0",
> -    "PublicDescription": ""
> -  },
> -  {,
> -    "EventCode": "0x528084",
> -    "EventName": "PM_L3_P0_LCO_DATA",
> -    "BriefDescription": "lco sent with data port 0",
> -    "PublicDescription": ""
> -  },
> -  {,
> -    "EventCode": "0x518080",
> -    "EventName": "PM_L3_P0_LCO_NO_DATA",
> -    "BriefDescription": "dataless l3 lco sent port 0",
> -    "PublicDescription": ""
> -  },
> -  {,
> -    "EventCode": "0xa4908c",
> -    "EventName": "PM_L3_P0_LCO_RTY",
> -    "BriefDescription": "L3 LCO received retry port 0",
> -    "PublicDescription": ""
> -  },
> -  {,
>      "EventCode": "0x84908d",
>      "EventName": "PM_L3_PF0_ALLOC",
>      "BriefDescription": "lifetime, sample of PF machine 0 valid",

-- 

- Arnaldo
