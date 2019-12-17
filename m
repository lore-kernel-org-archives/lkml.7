Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0FFFC43603
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 03:18:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB9AF2176D
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 03:18:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="V4TfRhRg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727071AbfLQDSV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 22:18:21 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:44485 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726446AbfLQDSV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 22:18:21 -0500
Received: by mail-pl1-f196.google.com with SMTP id az3so5390773plb.11
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2019 19:18:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=agmeJJwHgutPi6V5jPwGQYgXQ3xxL76EKh3hWRk6sjs=;
        b=V4TfRhRgroa8mXVVJXnFeVpyJc7ZKoYOuJQZF0r7WNOZSRM1GzwRQmStlmQRL1VXLP
         WkVEzqzQQYZUUpUWZ5njli4dzPmcmc7fVCibo8MOa7uTpRh3gYCgm8nwaH7LxS9xeIQk
         IMHpMPq07rkPzxwbh9bHYhiL99ufOnYTS1geio+okGkzkSnFqcrRqaY9WyoQgqNa5FRP
         uNu8UOeiz7nIS/5jWwzruK53Fgdxe3MurwZJQlEHiDjiJr37CLoBc5yPLhZN4MGHDPXN
         RdKKugfMMFpH9BdQROAe7Onyvcvz0OpSPQDqH372xCckxwhrgkgiyYmfJBF/Ek1vfCZf
         Pilg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=agmeJJwHgutPi6V5jPwGQYgXQ3xxL76EKh3hWRk6sjs=;
        b=o9/RWl1ZC2QFCNYomFpClHyxuXqH7NOXrXyI2UgsTeeI9+OjnmFVftygxUs5eUOlh2
         sxhHrBFaXw3XDLfDZWlMLAMpG20UHKPeZYCeQ5QqR6HOeJi6B/47xa/0ppgcS013uftQ
         xtGWzIeB0ETwrtN/YaktZD+j57l0XRFEc2uRF1c35mUTuviwF5oyA3gX6a4S0nB3/2FY
         GXVc5yuiynSYN4b3AwNXVRb7HlM3Rg5CYfrycpDUEVn9SyYYc4Esugb5BJpE5bvAdy0s
         JE7buO2zygbExxhYFe6Jt5fgfWoDTWeFkg3jfXGB2UfcA9YNhvl5m4EhwE1stO8mAMni
         1f3g==
X-Gm-Message-State: APjAAAXX5zNn8oETdXYuGIoYJ/YRgTHJCp/d1E5oO1B/Du9kTCHXR3AG
        VwbWMZqm1fqkVlCb1Lx+DbLX+Q==
X-Google-Smtp-Source: APXvYqxy02HSPh49Ch9sM24x3WbbcqSACRNLlkhhrwG6Omk42qWsbbJC2iHqcV+NpsLXw+rlfCLQqg==
X-Received: by 2002:a17:902:9a92:: with SMTP id w18mr19975363plp.91.1576552699188;
        Mon, 16 Dec 2019 19:18:19 -0800 (PST)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id 24sm24713060pfn.101.2019.12.16.19.18.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2019 19:18:18 -0800 (PST)
Date:   Mon, 16 Dec 2019 19:18:15 -0800 (PST)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     David Abdurachmanov <david.abdurachmanov@gmail.com>
cc:     Christoph Hellwig <hch@lst.de>, Anup Patel <anup@brainfault.org>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10/12] riscv: add nommu support
In-Reply-To: <CAEn-LToO9MjMr6ipXO1pCGG7H-bunHHAVyYkknOZ2dixOOG4+w@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.9999.1912161917350.64438@viisi.sifive.com>
References: <20191028121043.22934-1-hch@lst.de> <20191028121043.22934-11-hch@lst.de> <alpine.DEB.2.21.9999.1911171511170.5296@viisi.sifive.com> <CAEn-LToO9MjMr6ipXO1pCGG7H-bunHHAVyYkknOZ2dixOOG4+w@mail.gmail.com>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Dec 2019, David Abdurachmanov wrote:

> This seems to break kernel (5.5-rc2) compilation in Fedora/RISCV. The
> function above needed vmemmap macro.

Thanks, will take a look.


- Paul
