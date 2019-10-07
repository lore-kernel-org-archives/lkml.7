Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF8E1C47404
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 18:24:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B50A6206C2
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 18:24:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570472681;
	bh=ZOwM+w1Cf2s3uu99RayHAoXcuCsixqZHKsp8Nb73GHw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=tyZksiA1yPnPWvZyQZ4XhTrR6C/TJooSiXIeaTeVcI+MJSKNDeSBDJ/Gvp4H7Re9q
	 DWeHi7l46znxgIBckkOq63HEWGT3P6KDfDcxOHHf8uxMd7ywBKHRq8PPmZ6KslBu1f
	 C59VEclsuTX3Wf0IQ77XKp/biiZLzQK6v/S16G98=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729230AbfJGSYk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 14:24:40 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:37197 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728079AbfJGSYj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 14:24:39 -0400
Received: by mail-wm1-f68.google.com with SMTP id f22so501167wmc.2
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2019 11:24:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ezNABygrHKlNeoSH2vRdaMrsFPovCOpld0uUvRal6F8=;
        b=IMW/oamqgR1viKRa6KIjOEvchCEnykE3YVhhfwcvpVzawhOEbtGMBHlacQtc81SM+5
         mbHg8g6jVx5MMkuWhy0RvrWASkodRncAbG9TEzGYeB3kDhOE6NzHpEeakK0cafp2GGOg
         xK6URPW8kneEDrrUfPWyqJkiSd29p6FZNYpBiaJ4l8ymtXfsoKtu/Datb7uCEw7v85lX
         34lP1jp4POpmazQ/VF/6K7ZhhOTN5jlBgiO+6Vb6BfGTHYzRA0Jewn3QJI7lSMyoit94
         Ap4A/npYAJBlsdee5UewyIoLEhYQ3CBu5GdCxmM9my1rqdX+PMIdt0+1B2/OWdaa1fLk
         jB6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=ezNABygrHKlNeoSH2vRdaMrsFPovCOpld0uUvRal6F8=;
        b=dJMphbG8Rki0mWwbDMIKsV8ZQsCpaWf86HAA4blUa+oqon/BjnabdEh5q5Qa0eZgkE
         Q+53gfz1bnsCYlFlHCnljZ7QZFvO1TXZr33MW16lAGxSh7N2WbfDzS8i/cYOt5jxQoNz
         k7ZCg5D7czk1MbjznIoiC1frcS/51Tcxl78auljoxRZblUOUSfQNAZJXfd1L/xZJXikF
         IBQY+Vog41KlZsOrr4wjtYeAuC1EiI/bDa9gfmw1Bb/staPU7/lie9YFlJgXHVRq9eVE
         e0Wh0AiUso50PSZopgqFaQAGNyOGwzDWsRFqeSlmL1Y1k2P6UwYGh4ZzAEzCQ78tVffi
         dWkQ==
X-Gm-Message-State: APjAAAWrFpxxiWXpBiXQ781GREqP5C251gkfo7cJp0BJB72e8MvFVD65
        nMK4ko6C2wSrHnED1oW7gA8=
X-Google-Smtp-Source: APXvYqwbotev0iC+7bk13l+S6vJAkC2KuLF7ieohkGIO8pV80GfRKVZZ6ni9zm7xQVyfOqbPx++kzg==
X-Received: by 2002:a7b:c95a:: with SMTP id i26mr474264wml.120.1570472678331;
        Mon, 07 Oct 2019 11:24:38 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id n15sm2469389wrw.47.2019.10.07.11.24.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2019 11:24:37 -0700 (PDT)
Date:   Mon, 7 Oct 2019 20:24:35 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     kan.liang@linux.intel.com
Cc:     peterz@infradead.org, acme@kernel.org,
        linux-kernel@vger.kernel.org, jolsa@kernel.org,
        namhyung@kernel.org, ak@linux.intel.com,
        vitaly.slobodskoy@intel.com, pavel.gerasimov@intel.com
Subject: Re: [PATCH 00/10] Stitch LBR call stack
Message-ID: <20191007182435.GA97660@gmail.com>
References: <20191007175910.2805-1-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191007175910.2805-1-kan.liang@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* kan.liang@linux.intel.com <kan.liang@linux.intel.com> wrote:

> Performance impact:
> The processing time may increase with the LBR stitching approach
> enabled. The impact depends on the number of samples with stitched LBRs.
> 
> For sqlite's tcltest,
> perf record --call-graph lbr -- make tcltest
> perf report --stitch-lbr
> 
> There are 4.11% samples has stitched LBRs.
> Total number of samples:                        2833728
> The number of samples with stitched LBRs        116478
> 
> The processing time of perf report increases 6.8%
> Without --stitch-lbr:                           55906106 usec
> With --stitch-lbr:                              59728701 usec
> 
> For a simple test case tchain_edit with 43 depth of call stacks.
> perf record --call-graph lbr -- ./tchain_edit
> perf report --stitch-lbr
> 
> There are 99.9% samples has stitched LBRs.
> Total number of samples:                        10915
> The number of samples with stitched LBRs        10905
> 
> The processing time of perf report increases 67.4%
> Without --stitch-lbr:                           11970508 usec
> With --stitch-lbr:                              20036055 usec

That cost seems pretty high, while the feature sounds useful - is there 
any way to speed this up?

Thanks,

	Ingo
