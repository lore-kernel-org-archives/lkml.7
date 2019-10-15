Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92894C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 20:10:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6256420873
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 20:10:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="ZFC+xb5C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732927AbfJOUKn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 16:10:43 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:46821 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726717AbfJOUKm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 16:10:42 -0400
Received: by mail-io1-f67.google.com with SMTP id c6so49111376ioo.13
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2019 13:10:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=WIMp52CAKzHghF+2e/jNlYAAEKJd975b+6wt0t+FfVY=;
        b=ZFC+xb5C9+88Lpje8WEXOJoY+2xZ5x7gs2Pij4UgTRgFB9pF1VD1TecwCh7vttpvR7
         SnK98LgyU5vrvCaYONaPlvJMfvxSINVHZby4WleRgLPHQMAqUWK8WARFbxEKQriM8Flp
         mOyJeEyAzmAbHCOOG5mTCwRisXFvkeX1GHMWJGOUVbIC9hcBqrGa7XgShUZmlYUatnxf
         FUmJawI9dQyNGNCxH/VMvaiOYxJA5IpCpxEfG3J1W5ucSA7Hhn8UGFy7SXssVFAA8zGN
         EYvAYmZbhc36JofSH1bD9XAY17v3H1ewMpAAxK+TA/igOJ8BuyxxaoreH2qDzvmsFuoB
         8vjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WIMp52CAKzHghF+2e/jNlYAAEKJd975b+6wt0t+FfVY=;
        b=WX0MF22Em8YZGcYPoF3TGoaOoWqrsWLmYZU8h1QRSl1j3pJqb6DbNmIh+ZcYWxshU3
         CvyeJ1gkj0Qd61sUCMa91RZwCaFMflvH4x3ycfvjP9ABn8ZF4rIQiUzKhaF0k1jU4EVj
         7+KPzD2UafzyarEnudV6/3czVlu9kQ2hhHRXtho8bUsvuQFzajvlQY8vgivm6s8EMMuF
         FxvFPlTJPUhLsnynFz9h9rl2OdqLj4w8497nNMo8KlndUo7QNWXb5vX0oJCojy4gvVWo
         Au7euJTDyDT81qnN8qZrK+KOxOqooKdwSqLo2bS7czQnITtKSj7NbxH4q3poZ+wFuwKT
         NCXw==
X-Gm-Message-State: APjAAAVNuhiVYim8H9lVAZ5LnuA8r58otpb6loT5FMzGCx8LVrLR3sfu
        PphmTcDlL1tZ4Ggwn2XGEmwxRkzrenekyw==
X-Google-Smtp-Source: APXvYqxyc9zmaZsTAJUWgjjppuQ8/fMYKs46wjhkI7m32W+hC0YsBf37Vpge1QmmaM60S8JXyJrYiw==
X-Received: by 2002:a02:c544:: with SMTP id g4mr25058717jaj.79.1571170241274;
        Tue, 15 Oct 2019 13:10:41 -0700 (PDT)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id m15sm3030459ilg.49.2019.10.15.13.10.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Oct 2019 13:10:40 -0700 (PDT)
Subject: Re: [PATCH] libata/ahci: Fix PCS quirk application
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Andreas Friedrich <afrie@gmx.net>,
        Stephen Douthit <stephend@silicom-usa.com>,
        stable@vger.kernel.org, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <157116925749.1211205.12806062056189943042.stgit@dwillia2-desk3.amr.corp.intel.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <06a3c771-e6b6-10fb-fe8f-acaec2c3526f@kernel.dk>
Date:   Tue, 15 Oct 2019 14:10:39 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <157116925749.1211205.12806062056189943042.stgit@dwillia2-desk3.amr.corp.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/15/19 1:54 PM, Dan Williams wrote:
> Commit c312ef176399 "libata/ahci: Drop PCS quirk for Denverton and
> beyond" got the polarity wrong on the check for which board-ids should
> have the quirk applied. The board type board_ahci_pcs7 is defined at the
> end of the list such that "pcs7" boards can be special cased in the
> future if they need the quirk. All prior Intel board ids "<
> board_ahci_pcs7" should proceed with applying the quirk.

Thanks Dan (and others), applied.

-- 
Jens Axboe

