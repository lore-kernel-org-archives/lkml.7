Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21C78C3A59B
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 06:57:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9E1D20874
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 06:57:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="n8Pzfswh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726765AbfHSG5K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 02:57:10 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:35307 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725790AbfHSG5I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 02:57:08 -0400
Received: by mail-pl1-f193.google.com with SMTP id gn20so512836plb.2
        for <linux-kernel@vger.kernel.org>; Sun, 18 Aug 2019 23:57:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7k//502CULWRlumB5LUfrkH+oVCgs4LxV1yBK5FQWw8=;
        b=n8Pzfswhm9FPBsuTbYIHw3yt1vfkqvLayOSdP1/ZW5QfVYXmUG6Uf15GKoYaiwOzM/
         83br5UBUAxGwaXZEhBEF8hvzVqchUhiLfoSEWCUICWSFL+tG7LOQyxisR3JCGkAAtz2f
         9QbVzrNmosPVKq8kNz3DCin3Mebh1i7kdOYyUBR2vdkxgcKVFE86fAMG+nWNzzqVb0Gx
         uHCCEPU948leGvaytsBRo495cS4T3QwuqgTgrXicF4xyR64gNWoumRAoTkT4xbO7sGpl
         KGH9DBNL8U7ANBSyYIJV7f7IGoXaLjiNMLDKIoIPOOFCdKxQdx6zviuTXH5joz29eJND
         wOlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7k//502CULWRlumB5LUfrkH+oVCgs4LxV1yBK5FQWw8=;
        b=fhtlC9p3GCZbTMqof6co+Sh5hRZMTJrg4Sxwd6C26mOuwwhhkzf6ndcHNxFlmgAYZn
         HUmaxBQjIKkm42l2/v5+qsW+aYFrfJP8cP96J0xNqjWqiYJHQT2+gsOdxEjTEIrwVvr+
         KW/7wmitt4hV1I3jWJJPl+7khQdpO1dJBGvvFRXgbABUps1jgyHOEuDxP8PNbkvZy41j
         2K97vxTkOrBRPLFkFOrni40zrzSt4+dsB9FHaT2aomebw5FjOXejBY+AigoGBVk39P3Q
         Mrdsok0Qxoi8c1ySMmgDhNwg5v6dDzSSy2Su20QqD4PJiYq+kq+E31XCqRM58EjSWu6w
         s34w==
X-Gm-Message-State: APjAAAXFETSKZJY+c2/7eG979pJg7gbV3vPYGlVUd6n/+0lfzGUNagJm
        o5UOidK7Jw/PFWUyFrw1V6pDSA==
X-Google-Smtp-Source: APXvYqwtIiM2jQQRDwVLMDAvkIOLbhorGtgsQRqJtncX40+Y0g09W50Mmph5+k2/rKckttxro5j/tA==
X-Received: by 2002:a17:902:ca:: with SMTP id a68mr20639505pla.204.1566197828124;
        Sun, 18 Aug 2019 23:57:08 -0700 (PDT)
Received: from localhost ([122.172.76.219])
        by smtp.gmail.com with ESMTPSA id a23sm14891521pfo.80.2019.08.18.23.57.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 18 Aug 2019 23:57:07 -0700 (PDT)
Date:   Mon, 19 Aug 2019 12:27:05 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Quentin Perret <quentin.perret@arm.com>
Cc:     Douglas Raillard <douglas.raillard@arm.com>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, rjw@rjwysocki.net, agross@kernel.org
Subject: Re: [PATCH 1/2] cpufreq: drivers: Enable frequency invariance in
 qcom-cpufreq-hw
Message-ID: <20190819065705.qhcb4ohtsekik3q2@vireshk-i7>
References: <20190808131857.21082-1-douglas.raillard@arm.com>
 <20190808173230.53ddupihjlr6uvne@queper01-lin>
 <14762a81-a81d-d05f-b42a-495dacb28168@arm.com>
 <20190809103704.fatayhzso2b62fmx@queper01-lin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190809103704.fatayhzso2b62fmx@queper01-lin>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09-08-19, 11:37, Quentin Perret wrote:
> Actually, one nit, the $subject should probably be formatted as:
> 
>   cpufreq: qcom-hw: invoke frequency-invariance setter function
> 
> for consistency with other patches in this area.

Applied with these changes. Thanks.

-- 
viresh
