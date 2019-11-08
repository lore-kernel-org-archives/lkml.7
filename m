Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15CCEC5DF60
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 16:10:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF9542178F
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 16:10:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oqEeTImD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727492AbfKHQKV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 11:10:21 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:39547 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725941AbfKHQKV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 11:10:21 -0500
Received: by mail-lj1-f193.google.com with SMTP id p18so6793528ljc.6;
        Fri, 08 Nov 2019 08:10:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=maXB2VDh1iEy51lmhzDifsWOuishbsw0vRYJa/MLM1w=;
        b=oqEeTImD7QhX3gkeREMKMpoh6gS7ja6krWrEBEGoDyizlyai8REIiCv1/BxQyLI4uA
         LHYz7L3UOWpgQ+YqGYdHYSYpivIwNhuAWdWcg8xjG//usBZGCPNiSItSfhlS+OJAutpl
         4kwzjjBALkVR4MRmv71DRBq8Wd60vv3HtVSAd2iNXY4xfccE0VW3D+YvajqnIft6Gumr
         v8zo2W+s7LYAHnH+y6yARrBe1Kxzl9deza0+5KXDS8ZW5+yio6cd7XeFOnSHghTjS1hI
         N9lVML9v4lzNS9GND4WqwlkvBRmAy1yfjB1EzI0RXaFBf8UK7mo/xukpMfW+F1we4bI/
         4pwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=maXB2VDh1iEy51lmhzDifsWOuishbsw0vRYJa/MLM1w=;
        b=gSLmzpglszqRwqPWkeMrmzHSp3reYlBnJR6OhJgpgxWgMNuhcU+ccsXvWUkeQxEWw0
         if91eVyzpD3PFboWgxzAfqZS5XBR+2avpvVKVfdEBxmCO9uGh1lqnuOlNcfkVADUd1f8
         tchYZNFCjhe6Wh3y/iPf0zSGp9OGlQHytIbFwMVJVOXcGuK2yPKyO7y6nMiOLtDYdZlY
         X0anEreR7YZJ6IzPqBaZwA4XrT9dOZotd4Gv+hApGUDgggfgv4IQ0oQ5v0OZJn9SkqGk
         C/7jc/tVNSfWOHXsKDYCDkDHSqNTYKbo9wtQ72KTETmqDIkMLuRISYYL2Z7jtpotkHUq
         VxGQ==
X-Gm-Message-State: APjAAAXjqj6ps6RnwWSyfO/TX2nRSIsAjtcWspzsHZrvHCMwMNPtFpYm
        zQB4AMNtZCSExh4xSXuLc/lWqIOvXmg=
X-Google-Smtp-Source: APXvYqwn3ELRFg5N3AOkRRVlah39osyzUX5pW8Z9h3bihHb95B6qSv+AnQnWL7P/KcKzeMcjatiYGw==
X-Received: by 2002:a2e:884c:: with SMTP id z12mr7242088ljj.41.1573229419486;
        Fri, 08 Nov 2019 08:10:19 -0800 (PST)
Received: from [10.0.0.92] ([91.237.107.85])
        by smtp.gmail.com with ESMTPSA id 30sm2260478lju.52.2019.11.08.08.10.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Nov 2019 08:10:18 -0800 (PST)
Subject: Re: [PATCH v3 0/3] asus_wmi: Support of ASUS TUF laptops on Ryzen
 CPUs
To:     linux-kernel@vger.kernel.org
Cc:     platform-driver-x86@vger.kernel.org,
        acpi4asus-user@lists.sourceforge.net, chiu@endlessm.com,
        yurii.pavlovskyi@gmail.com, kristian@klausen.dk,
        andy@infradead.org, dvhart@infradead.org, corentin.chary@gmail.com
References: <20191107230105.30574-1-leonmaxx@gmail.com>
From:   Leonid Maksymchuk <leonmaxx@gmail.com>
Message-ID: <3b0d8afb-142d-94fb-d53e-597348b9fc7f@gmail.com>
Date:   Fri, 8 Nov 2019 18:10:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <20191107230105.30574-1-leonmaxx@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please ignore this patch set, I'm working on v4 right now.

