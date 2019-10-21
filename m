Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4960ECA9EAF
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 10:54:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2031920882
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 10:54:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qfF24aXt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728264AbfJUKy1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 06:54:27 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:34936 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726767AbfJUKy0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 06:54:26 -0400
Received: by mail-pf1-f195.google.com with SMTP id 205so8203609pfw.2
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2019 03:54:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=H2t4PKG/eZU3aPmwrkuhhD8Hh2tscnAFAhHGGRBX4YM=;
        b=qfF24aXttATO4K858iDxMOlawG2W88V2Efd1HhVKFd7Tq7BO/h2cM7JmXZTa5Mwa0n
         GfyvpWvUQn8jaJqHg2hK8cPDRim5U8SNXlsjoSYVCtedIJMyrVyTmGNQ0sF8JqGcfXhY
         9u2btxLWxsUmAVw6n8IDr6kds1pz3kXtxNMITR3vegl3bNMahBUcZzG3LfY4wKJ2124X
         6QJ5n3buU28VZAiUjoyec1z37S4prkbnEpWx5UQm5GS0KfWbdVPaouRS92IGfOU4VNJl
         NJ1IXxGMZo7fBioOuzrNEe4FnMeYHuB88Jb8a6Kwphhz6o+p5N8Bm2GRX+CUlu7DuCf1
         wQRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=H2t4PKG/eZU3aPmwrkuhhD8Hh2tscnAFAhHGGRBX4YM=;
        b=mcY2WJF7PlrTD1abSoJphNxTU3zqQ+S2Uy6l2J7rGgvgXomBg9EqtJY9nWW89Rb9Sg
         ijIC1ttPsVxRR2fO60o76bSIzbn8OXav+wjQknG5+g8yBoAQt/la17Sk3Ne9oXCe1Z6C
         3jPnhwho94YT+r6FxxFPRYQu3Sly+9zYH1t8XWWsK9Z3q6zRoYepb6/nA4ywo2T1UTnz
         drd1U4h171yfTuoDOf/YlxeTZYTRJ5emEcs2mBMN3XNIWdMrkkwfnKvLK6v6Q0+SMmob
         umXftmwtgV2jOWQ1dlgA7Yy1lVdA6uz+OIQvH5g6p8n+djcLjsIbVNrHneVu7uAv26n0
         AbIA==
X-Gm-Message-State: APjAAAVUBQTaC9KI2d0dXktjoebUQ8SX76UNq6UTgYU28SnqtN4vSs8K
        xEfMtgUzDHsISUCpTuw9Z8zWT366AeA=
X-Google-Smtp-Source: APXvYqzc+VIvFaAIr1m5192kISlYR+tFNl07KgG0K9Am2YZM+hvPaKnDaJ6T+4BBNOPsidRHUzrl9w==
X-Received: by 2002:a63:3044:: with SMTP id w65mr24426425pgw.384.1571655264745;
        Mon, 21 Oct 2019 03:54:24 -0700 (PDT)
Received: from localhost ([122.172.151.112])
        by smtp.gmail.com with ESMTPSA id o60sm15848553pje.21.2019.10.21.03.54.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Oct 2019 03:54:23 -0700 (PDT)
Date:   Mon, 21 Oct 2019 16:24:19 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, nico@fluxnic.net
Subject: Re: [PATCH v3 0/5] cpufreq: merge arm big.LITTLE and vexpress-spc
 drivers
Message-ID: <20191021105419.ud7he23j2icrwo4w@vireshk-i7>
References: <20191018103749.11226-1-sudeep.holla@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191018103749.11226-1-sudeep.holla@arm.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18-10-19, 11:37, Sudeep Holla wrote:
> Hi,
> 
> Since vexpress-spc is the sole user of arm_big_little cpufreq driver,
> there's no point in keeping it separate anymore. I wanted to post these
> patches for ages but kept postponing for no reason.
> 
> Regards,
> Sudeep
> 
> v1->v2:
> 	- generated the patch using -B that helps to keep delta short
> 	  for review
> 	- Split the last patch into 3 different patches to deal with
> 	  removing bL_ops, debug messages and other code formatting
> 	  separately
> 
> v2->v3:
> 	- Added Nico's ack
> 	- Added back blank lines and extra braces as suggested by Viresh
> 	- Updated copyright year correctly

Applied. Thanks.

-- 
viresh
