Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6EB0C2BCA1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 11:38:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAC97208E3
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 11:38:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="VAIH6Cy3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728719AbfFGLh7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 07:37:59 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:40950 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728306AbfFGLh7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 07:37:59 -0400
Received: by mail-lj1-f193.google.com with SMTP id a21so1429564ljh.7
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2019 04:37:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fRds4+BVAv/doBLU8hXnnNZ1HhXNCYgPq9/hyaBuW3c=;
        b=VAIH6Cy3IJTyIkF83L8zSWEKjVVk6CK49bnH+GtoEXsWIB9z831zxjNeAZD9ThvxcP
         DqwYZpujX1Bqo1EvQDMzl1vIjcGPTz+Yk154RrQGEHxeAsN94bpNoxSkUeGTjUA6ZSfK
         nLHHtEVNzmsdgJUEfs0/sO+i64nOwtB8ZNVmVn2hbwtNf1CyFoSSZ5s/TsyzYy55H4pM
         c3gegD5SIHxDIqzWjr+/T0qBTE9uWUzhshlJX/aBD9lAMsAZc2xY20hZzQsCgzSte+V+
         1c7V/8yFluekIUBwSgH/ejhBlzRashoehBA3z0c84+v0SjMDeuZFu9rRhlNw9ZXO/tz4
         O/cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=fRds4+BVAv/doBLU8hXnnNZ1HhXNCYgPq9/hyaBuW3c=;
        b=QVtdiPYukxYkS32rSEc0pVyrjvAs2zZGvl5WPX+PNAw7aHhBW6J4QK3DPTBMuG0CAw
         0fuXWz5uEDgxw2YHziQ+oULk1b0wqwHdnz8TSvnbGjxq3ja0gQXKoeOuqnBkViwujA/k
         c/UjFGe8Qt0tdSzpuZZphu/r4WnpgjjswV9YOC4QTizCETqe2331oENgKgBwnvqvafpE
         TNGEdbodTLLJ0FgvgVSmLdivZHYYKe3j+9wcK1B0SOjkHGRh/f2edUEI5KLVWPveQhUj
         PBjTwY0d5IHSq+JyZdKl2dHFmAamnj2WmN7raJL9OFOXiBUDmoELz2aaPmxUi0u1HmtP
         mDjg==
X-Gm-Message-State: APjAAAUaliyZpQ6AAmSGyO8mPeCcqojCOjlnS3aDKRr+Wz4B/+F9IIsx
        KWmOG2IGo0fDXl3BKgmF8V6mk5GM70E=
X-Google-Smtp-Source: APXvYqzjPp0FChqLKiUc7SZMya2ciwcmsp6uDZ30YcA8bLLgXx79donMwCBINLwrj+/6lz4LMjtoZQ==
X-Received: by 2002:a2e:9e14:: with SMTP id e20mr27260572ljk.172.1559907477284;
        Fri, 07 Jun 2019 04:37:57 -0700 (PDT)
Received: from wasted.cogentembedded.com ([31.173.83.123])
        by smtp.gmail.com with ESMTPSA id a18sm341299ljf.35.2019.06.07.04.37.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Jun 2019 04:37:56 -0700 (PDT)
Subject: Re: [PATCH trivial] net/mlx5e: Spelling s/configuraion/configuration/
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Saeed Mahameed <saeedm@mellanox.com>,
        Leon Romanovsky <leon@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Jiri Kosina <trivial@kernel.org>
Cc:     netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190607111026.12995-1-geert+renesas@glider.be>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Organization: Cogent Embedded
Message-ID: <1e408f5d-04f8-99f3-0452-9638ea0b9d69@cogentembedded.com>
Date:   Fri, 7 Jun 2019 14:37:55 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20190607111026.12995-1-geert+renesas@glider.be>
Content-Type: text/plain; charset=utf-8
Content-Language: en-MW
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On 06/07/2019 02:10 PM, Geert Uytterhoeven wrote:

> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

  Unfortunately, while fixing this typo, you made another one, in your subject. ;-)

[...]

MBR, Sergei
