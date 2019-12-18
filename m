Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8BB6C2D0CD
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 06:39:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E61F20716
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 06:39:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MKEllDJm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726694AbfLRGjt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 01:39:49 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:43715 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725799AbfLRGjt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 01:39:49 -0500
Received: by mail-lf1-f67.google.com with SMTP id 9so814187lfq.10;
        Tue, 17 Dec 2019 22:39:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=0PhahhQ0p/xZg2C/dJvoZ93qDA05w+8cBI6dXssirME=;
        b=MKEllDJmQY5uQLF0cfhMOWDg0O+QADZWmnKXaO1Ys05qGEme6VnsyV4JgUuGSZHQn2
         gbo4j/V/T3Cwf1G0LAr00l4uGUCmGLh/fhAAqiNx/g+iNdHnxj+enoRH+lGl70jaXH9z
         GxLRaSnVyc/62qTZc7sWbSJk3WPBSXYpDlluxn/awFCyKZp75qTYmQIConggFHaj0z3v
         gVNG5dMtCEJXCXJ66e5x/+5alZiC1BqSF/6BRhY4/6cKNezyK0SUJYontha9priGJSDA
         FuVPOe3cM5rGgahWbrVbAQiZ1CUqyUQVu97M2wk+AvUFdoj/3X674mIt4uVXyt0/++Tr
         D+zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0PhahhQ0p/xZg2C/dJvoZ93qDA05w+8cBI6dXssirME=;
        b=B3y5alLNqL7P4NVG9qJ5GfJ0NdwBLxQ69vWpgaAfqrIGB2J6XZdLDhBbgs/6uJ5NN0
         uvc4fZFNOVHE35zJiOtoxZYiZV6PQmzVwwYvr2aJ0u920Vzr+y0LncPThoUyHqIaukdm
         7DGZdOW3VPX5YOjGewPhPjjPrIffSq2refSLGyURSPrbjYcYp+1tPzenuwYXF6yiCjzc
         h8hzuiCCF6DL+nlePit4YsD8XUWPZoh5DMFACFEbqiffwbHW8p0/xRaTJUXZXF1urKaK
         xmqsKEWH6hOEtJZnNiA/Xv5Lb/ZzhsTqDSmqhOdz3BH1Q5pEadcEDbie1KL4wkoFnCN3
         1HGA==
X-Gm-Message-State: APjAAAVlr5XJraDrJatAyPuI6Y3El7g+qTYcIqBlCdjnAYworfTBckVu
        mhBqpz5jQNtlQ5QCG+6u7Fki8yTz
X-Google-Smtp-Source: APXvYqxBFp0SR1sdaMaqdlgwEdNK7azflimv2FNu0xc+eES+p3/QWxyVnKC3OZu56qkldt+1bugd7g==
X-Received: by 2002:a19:f716:: with SMTP id z22mr676613lfe.14.1576651186608;
        Tue, 17 Dec 2019 22:39:46 -0800 (PST)
Received: from [192.168.2.145] (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.googlemail.com with ESMTPSA id u24sm479158ljo.77.2019.12.17.22.39.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Dec 2019 22:39:45 -0800 (PST)
Subject: Re: [PATCH v4 17/19] ARM: tegra: Update sound node clocks in device
 tree
To:     Sowjanya Komatineni <skomatineni@nvidia.com>,
        thierry.reding@gmail.com, jonathanh@nvidia.com,
        mperttunen@nvidia.com, gregkh@linuxfoundation.org,
        sboyd@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com
Cc:     pdeschrijver@nvidia.com, pgaikwad@nvidia.com, spujar@nvidia.com,
        josephl@nvidia.com, daniel.lezcano@linaro.org,
        mmaddireddy@nvidia.com, markz@nvidia.com,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1576613046-17159-1-git-send-email-skomatineni@nvidia.com>
 <1576613046-17159-18-git-send-email-skomatineni@nvidia.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <f76bf618-607a-af87-f652-4117ed050b70@gmail.com>
Date:   Wed, 18 Dec 2019 09:39:44 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <1576613046-17159-18-git-send-email-skomatineni@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

17.12.2019 23:04, Sowjanya Komatineni пишет:
> clk_out_1, clk_out_2, and clk_out_3 are part of Tegra PMC block
> and are moved from clock driver to pmc driver with pmc as clock
> provider.
> DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
> 	t=1576613055; bh=aZWp4sScdv8qprM+UpGS0w1DX7YelR50gFqoThf23X4=;
> 	h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
> 	 In-Reply-To:References:X-NVConfidentiality:MIME-Version:
> 	 Content-Type;
> 	b=p9EmVtuTvJK6owqo0lmnZnAvftCWc6+7Mkp/Ks9y26tKN5c4jU+I+YEAaMWoHuzd+
> 	 7n0vS98WNMGomj19IUXoaH49IeTgPAlqOkU57IIiL2qEnX3sYNYpl/rCRUIs7vd33t
> 	 LSn8tQeu9Lz+Yfl8hvXcN3sdxRQOEPDYwzWG+tVy1FCnwouTHSfBhgado2Tx/9cWgi
> 	 HlSWkzjvodag7mAmZtLCl5P4J+oVEJnpYnjSZKNojqszn8u651ErvnVI/VbhZwQ0G5
> 	 Yg8kEr8YECPk2L4MXUe8J2YmKtNyZaADOkUhjyxqMjZ2bGrB9RDm5dKNFxkWuEeSpb
> 	 U3nMi7MNcvBmQ==

Looks like NVIDIA's mail server has some problems.

[snip]
