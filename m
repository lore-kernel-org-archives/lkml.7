Return-Path: <SRS0=8q5G=VR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 436AFC76188
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jul 2019 15:15:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DA2B2082A
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jul 2019 15:15:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jGkVSbSr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726284AbfGTPPa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Jul 2019 11:15:30 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:40063 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726020AbfGTPP3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Jul 2019 11:15:29 -0400
Received: by mail-wm1-f68.google.com with SMTP id v19so31521811wmj.5;
        Sat, 20 Jul 2019 08:15:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:cc:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=0O9EEzNqXBLnWr63egXKDae+FfWFYUOTBOq+HADyu3M=;
        b=jGkVSbSrpu5JENmVqj+cPzobFHm5lq5nYn0EcgAyPltrxKLd3+QNTBc2KJALSMg1Mk
         suPXJXPGMREM9cYxcnjerc5ZwRM614xvDq5HHETb3cNpeGgpmsArq4MfjcurVpHuzDGs
         rqWaqFM25tvjPkC3uQwkBqbwjjVW9s/xzc08vh5JUn2+97hgM4GzjSjyKfCFVVtV/RZQ
         l32yX1Xg3YvAqXS/ARvtUj2BysqhC5HcFSie8UDYjeuGntsx3svTBh3pFmLuv4vuoOfq
         6/58xeajoZkagQ5T5/NcYPJb3EeMAqAU5qowYUZMk1on5ABm4/yQyLoESYn3ixra4uzm
         mXJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0O9EEzNqXBLnWr63egXKDae+FfWFYUOTBOq+HADyu3M=;
        b=AvDuNhdI+B14VusdS5sQLL1o7CcMp3+9nNNOn+aYCy1ey4yYMGy0zd6S7wRmW3pkeH
         MEZSXhr8zwOpLA+JDIgHiB7MJGLHDhNg2mNAWbWv5MkDJ2h8e3HI25vcDdxSDEHmaNhb
         mfhGctaBjznNHwt+FLYiFhRa2A6jYtJAnhj/LhQEtJYfZzgsDr2WfteTJaEfDklQPTBl
         eM2BfwYacDk6G0Q7DVsPBS/x1aO6/uzwKG2xhOrFg4AJ36XBBmzVBdBtEnOFyDFGZPLg
         aVjoSBlqBpP/2MjdKXyv7/c+7VEaJxZRrs/hDZ5qMuUsq+zIfkEHx0os+U77caCKs5YO
         vWOQ==
X-Gm-Message-State: APjAAAUegJhYQytCydebHmwP1EQ/zgt8r58Ls9ymOSDEhbULGlxAlnVl
        amYWR2Y8c1GN9YBFcnk/v9s=
X-Google-Smtp-Source: APXvYqysS3/H3gpmFRQiCpddyaH6n0kS3Byb39y6qhsIXO1kQXI7i0qkDz7MBwqpf0tlCVlmIO2klQ==
X-Received: by 2002:a05:600c:2182:: with SMTP id e2mr10575646wme.104.1563635727466;
        Sat, 20 Jul 2019 08:15:27 -0700 (PDT)
Received: from [192.168.2.202] (pD9EA3BA8.dip0.t-ipconnect.de. [217.234.59.168])
        by smtp.gmail.com with ESMTPSA id x20sm71483058wrg.10.2019.07.20.08.15.26
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Sat, 20 Jul 2019 08:15:26 -0700 (PDT)
Subject: Re: [PATCH 0/2] Support for buttons on newer MS Surface devices
Cc:     linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        platform-driver-x86@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Chen Yu <yu.c.chen@intel.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
References: <20190702003740.75970-1-luzmaximilian@gmail.com>
From:   Maximilian Luz <luzmaximilian@gmail.com>
Message-ID: <5cf7bf59-47b2-4f70-ecb6-ad35e14eb793@gmail.com>
Date:   Sat, 20 Jul 2019 17:15:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190702003740.75970-1-luzmaximilian@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I have updated the patches with the requested changes and sent a v3.

Best,
Maximilian
