Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04637C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 21:09:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C302E20684
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 21:09:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cXHVfjOr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726415AbfCFVJj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 16:09:39 -0500
Received: from mail-qt1-f175.google.com ([209.85.160.175]:33832 "EHLO
        mail-qt1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726336AbfCFVJi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 16:09:38 -0500
Received: by mail-qt1-f175.google.com with SMTP id w4so14624198qtc.1;
        Wed, 06 Mar 2019 13:09:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=f0Ont26o++2BaqlQ1R1g6o+Brst2S+A9UsEMULSMNc8=;
        b=cXHVfjOrGzm15KvDHscI2qSKVhZ1hciHIaZjaEXyK0RoyigUTlauSK5/U+BhckmIBN
         oj6KVR4brswbuFCenNS7SKZ9S1rSK+JkZ+MZE+m0pm8DD/7Z1EOlcN7tijpqee03wAfg
         fSGLuK++6eC2SfsfAaxQZFaH5bGQugPToegMXOrQv/JJjVn7aq6s2YwbaFXZQVyiEQJU
         /fPPL+EFjNiUNjWlXzQXslzbmZj4C0tDgE+HUwa7p0rSufdopJx4lgEKLN01QstRuetz
         meq3SeX41EV1Dotv7IXvN+fE973WG9FjkfblAjTwiL+GS90+Z2ZajbatjLR/r5z/Be3L
         ebRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=f0Ont26o++2BaqlQ1R1g6o+Brst2S+A9UsEMULSMNc8=;
        b=rotRdZtPIZN2s9LvmoS/wASpq0cVAwo0fsaZGsKwgM5VqGBspWje2togv4ToaV+Q8d
         uT8YbzgjBH7J8h3Ia4lhRvdtPz7TxBldJvgR16T4ANwc6liIiZI+fIeLnNJEIshtUj7H
         wNj8wmKN/HHjeTyyvC+XAP/8dcuuqBNnj/aPmDPw5D2hoGa3NOex7dkBRtU2oyN0TMwg
         JUhxZV0Rb0U0xQhLBs1utrJxFVDEUhwXkYwmXaldOQ1rHKzQ4iIxi79Exm0UeGcLpkTx
         Li/k6BIV9Y5eB7UtIUjznZWUceNJcsfFBhKi/eDSYu76b2oJ2wyIIlC45pYJn3Ro9Y3z
         fTZg==
X-Gm-Message-State: APjAAAV+sAQTD+TrMvv5oQFffaFFvlCLTqqDe9nO7Vs8RJl9+JPxOAm8
        ygmDmfZFvsuLPqxDg7Zj+XY=
X-Google-Smtp-Source: APXvYqw5PSylrO3Qj0xdsVXjJgvwyzltLhg66kEhM68Fc9S7sIQBK6AS6XNwKHN3jijZTp3CipGoqw==
X-Received: by 2002:ac8:3fa3:: with SMTP id d32mr7302728qtk.51.1551906577652;
        Wed, 06 Mar 2019 13:09:37 -0800 (PST)
Received: from quaco.ghostprotocols.net ([179.97.35.11])
        by smtp.gmail.com with ESMTPSA id f8sm1389243qkl.11.2019.03.06.13.09.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 06 Mar 2019 13:09:36 -0800 (PST)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id C60FA4039C; Wed,  6 Mar 2019 18:09:34 -0300 (-03)
Date:   Wed, 6 Mar 2019 18:09:34 -0300
To:     Tony Jones <tonyj@suse.de>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v2 1/7] perf script python: remove mixed indentation
Message-ID: <20190306210934.GM30734@kernel.org>
References: <20190302011903.2416-1-tonyj@suse.de>
 <20190302011903.2416-2-tonyj@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190302011903.2416-2-tonyj@suse.de>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Mar 01, 2019 at 05:18:57PM -0800, Tony Jones escreveu:
> Remove mixed indentation in Python scripts.  Revert to either all 
> tabs (most common form) or all spaces (4 or 8) depending on what 
> was the intent of the original commit.  This is necessary to 
> complete Python3 support as it will flag an error if it encounters 
> mixed indentation.

Thanks, applied.

- Arnaldo
