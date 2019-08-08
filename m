Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAC83C433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 13:53:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C593208C3
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 13:53:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ebc6L5/o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389822AbfHHNx2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 09:53:28 -0400
Received: from mail-qt1-f171.google.com ([209.85.160.171]:45606 "EHLO
        mail-qt1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732882AbfHHNx2 (ORCPT
        <rfc822;Linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 09:53:28 -0400
Received: by mail-qt1-f171.google.com with SMTP id x22so18779793qtp.12
        for <Linux-kernel@vger.kernel.org>; Thu, 08 Aug 2019 06:53:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=B6GUlWEfN61r4a+noirksPYG7utOfNFpK+VS1HZsVBo=;
        b=Ebc6L5/omcTW/ghRcQz41irZXhhE662yBuscojOnBvMApvp1XJeLzSRIGvaxshGMSh
         +J9cj72kf4s2fAIDvI54jXJdNy1N8nIMLGeu/1fe4srw+5PDTC9teDV7YQTWjyjcJ+b4
         ocevR/+yJcaq+BmA4WkxmBv+awbDxU3n3gAofN/LLT0oUr3pCk0NtsYp6w8oGYJkjAA/
         kZPmN5QI4edlw+gtmhqh6sF6lJ+x//5GZWD24AkuYshRHAGMp61PhDRIVmlNKXEVX7Zk
         wcnSgvpY26H4DbOE2/goHoOA+o4vBlhTgeZS1f0MC2JEckGieFf073q85Py08WTsYiwv
         8RWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=B6GUlWEfN61r4a+noirksPYG7utOfNFpK+VS1HZsVBo=;
        b=hsG1vTFgXYCFwzCV1OuDWpL9aywKp2/xZJQN5bqmnWvqhUsnyrIMkQEH2sK9o72a2S
         yu2Bf8uTFPhVApfHRy413WVDw9RJT8B7BgF66yWtOGqWymG3KARq1d5hMmte8+S56Sej
         bI/5pzDy5sGoWdGv8cxFNkIBXx51KbQ5owiofssZ//ML3vZbCJLnO4HczSXBzOiOqavC
         NXlCJyyK+8swGDBXmrBnVvi2IuITdsDokUW6yp/BNEki0jX8bfMpXe5r4EapRKF57qvD
         qDjZ2nvBEFBJTlKosVp50xzY2dxu3DCKmh0hiIVVy/yTFfLdl7I+WVLYillS4m1bcU7w
         ZLSw==
X-Gm-Message-State: APjAAAU4LD8BaQ6fbd8axWXzLfCMkEZ7M/eVsYxDEvm+z/8xbG+492ZY
        avybAFXv7F1gtA7MsC72CVA=
X-Google-Smtp-Source: APXvYqxeB9mF6mU8Hxk4B3KSfXkBq7Hhs0ECwbrAzoJhMbArZ7sqJy2E35T0OuDgDm3cQmG6seVsmg==
X-Received: by 2002:ac8:31d6:: with SMTP id i22mr13655540qte.338.1565272407133;
        Thu, 08 Aug 2019 06:53:27 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.35.50])
        by smtp.gmail.com with ESMTPSA id h4sm1148165qkf.126.2019.08.08.06.53.24
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 08 Aug 2019 06:53:25 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id C341E40340; Thu,  8 Aug 2019 10:53:22 -0300 (-03)
Date:   Thu, 8 Aug 2019 10:53:22 -0300
To:     "Liang, Kan" <kan.liang@linux.intel.com>
Cc:     Haiyan Song <haiyanx.song@intel.com>, jolsa@kernel.org,
        peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, Linux-kernel@vger.kernel.org,
        ak@linux.intel.com, kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH v2] perf vendor events: Add Icelake V1.00 event file
Message-ID: <20190808135322.GH19444@kernel.org>
References: <20190724022744.5374-1-haiyanx.song@intel.com>
 <8859095e-5b02-d6b7-fbdc-3f42b714bae0@intel.com>
 <ffd8275f-6eaa-58b7-dc17-7058b42249d3@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ffd8275f-6eaa-58b7-dc17-7058b42249d3@linux.intel.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Jul 24, 2019 at 09:08:56AM -0400, Liang, Kan escreveu:
> 
> 
> On 7/24/2019 2:32 AM, Haiyan Song wrote:
> > Hi,
> > 
> > This patch contains lines that longer than 998 characters,
> > I've sent it by 'git send-email', but when apply it,
> > prompt information "error: corrupt patch at line 2558".
> > 
> >     https://lkml.org/lkml/2019/6/24/1278
> > 
> > I checked the line at 2558, it is very short line.
> > So the patch may be truncated before applying it.
> > 
> > Could you let me to send this patch as attachment? Please check the
> > attachment in this mail.
> > 
> 
> The attached event list looks good to me.
> 
> Reviewed-by: Kan Liang <kan.liang@linux.intel.com>

Thanks, applied.

- Arnaldo
