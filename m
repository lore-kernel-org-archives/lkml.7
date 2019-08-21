Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89F3FC3A59E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 12:09:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58A7522CE3
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 12:09:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="1mTbly5h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728007AbfHUMJz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 08:09:55 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:40072 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727448AbfHUMJy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 08:09:54 -0400
Received: by mail-pl1-f194.google.com with SMTP id h3so1236403pls.7
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2019 05:09:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=UT6yE/roxwyyBSRfLOwrFlilraLjBXjoNWJQAsldDVo=;
        b=1mTbly5hNN6suDS+BwBXn5tZNQRoJv3U+6eGIZWkxOpX8gp4MfK0srbyshCamPl8cE
         oynbwAZaUVd3iYuDw/fFqllqnUyyMdhGmWDFTWD0+uRBHO1RABomqwNTPTloesNaBCP/
         OF0wNlT1X2HUApuEYt9hqsB3ukfCOmKOxQ9VlFGyTVla9DArrhzV46cf0e1hqSL0Em1S
         kMKT+OUOB39Lc9u+MllIcA6W2VixaWAmIOOCqIPym//+KF+bJLzrXd5uXWfD6RF+tn8O
         fEItbmLNgpz+3xyfCw5xuoCb8BCqv/jPsevOVEPakCBbt5mOdjvlnK19JQHJXISJTFII
         +AuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=UT6yE/roxwyyBSRfLOwrFlilraLjBXjoNWJQAsldDVo=;
        b=bi40x9zNIBQ9O3OhHhg9U2w9WFXTXMuHZD1MbooOSVKnF2vr6uUn0p23ZmVgfeljDS
         AUIfMjVHdwvfu999Xiu0J3jGlRYscn84y22lVg91iGLDnXQIIF9Xox0oxJsP1w3qFDpq
         ChWhEnEwBlv7JinEhLSnVoKIBcdbjnxJvjZwcXbG/O9XLFMtBzSY8FA2BPnbb2ZtvIGx
         ABjqoxncDK3RM8jG7Qty2xIURq8nR2frpqs6xTxEALc4+RAUc2SYxMZsxL39sN8RFWFe
         AuAO7r9m8kmY+e+bsEQHYfrYEJMGsKFR1xuBykCW7lbW5wvjv7pv3weCYNvSSONofF1l
         QlrQ==
X-Gm-Message-State: APjAAAXULZob+sshrYmpadBlgLT4fZyfpBa0kLGDNlX/W+YbwD0EwKOf
        6a80gEU21iZ/SHKOd7KoDxic8g==
X-Google-Smtp-Source: APXvYqxsoe31YiWALXWqRLHXasZTZR3nM8GXNUHwTUUu4EkoxYDPJeCxhjU4HkYSZ/HpLNbIJ9AOOg==
X-Received: by 2002:a17:902:a410:: with SMTP id p16mr17723995plq.150.1566389394293;
        Wed, 21 Aug 2019 05:09:54 -0700 (PDT)
Received: from [192.168.1.188] (66.29.164.166.static.utbb.net. [66.29.164.166])
        by smtp.gmail.com with ESMTPSA id z4sm22521476pfg.166.2019.08.21.05.09.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Aug 2019 05:09:53 -0700 (PDT)
Subject: Re: [PATCH 5/9] block: support diskcipher
To:     "boojin.kim" <boojin.kim@samsung.com>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     'Herbert Xu' <herbert@gondor.apana.org.au>,
        "'David S. Miller'" <davem@davemloft.net>,
        'Eric Biggers' <ebiggers@kernel.org>,
        "'Theodore Y. Ts'o'" <tytso@mit.edu>, 'Chao Yu' <chao@kernel.org>,
        'Jaegeuk Kim' <jaegeuk@kernel.org>,
        'Andreas Dilger' <adilger.kernel@dilger.ca>,
        dm-devel@redhat.com, 'Mike Snitzer' <snitzer@redhat.com>,
        'Alasdair Kergon' <agk@redhat.com>,
        'Krzysztof Kozlowski' <krzk@kernel.org>,
        'Kukjin Kim' <kgene@kernel.org>,
        'Jaehoon Chung' <jh80.chung@samsung.com>,
        'Ulf Hansson' <ulf.hansson@linaro.org>,
        linux-crypto@vger.kernel.org, linux-fscrypt@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-arm-kernel@lists.infradead.org, linux-fsdevel@vger.kernel.org
References: <CGME20190821064226epcas2p2835b8a9084988b79107e54abfc5e7dab@epcas2p2.samsung.com>
 <004101d557eb$98b00060$ca100120$@samsung.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <6ea5e5db-4dd4-719f-3b3e-b89099636ea6@kernel.dk>
Date:   Wed, 21 Aug 2019 06:09:50 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <004101d557eb$98b00060$ca100120$@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/21/19 12:42 AM, boojin.kim wrote:
> This patch supports crypto information to be maintained via BIO
> and passed to the storage driver.
> 
> To do this, 'bi_aux_private', 'REQ_CYPTE' and 'bi_dun' are added
> to the block layer.
> 
> 'bi_aux_private' is added for loading additional private information into
> BIO.
> 'REQ_CRYPT' is added to distinguish that bi_aux_private is being used
> for diskcipher.
> F2FS among encryption users uses DUN(device unit number) as
> the IV(initial vector) for cryptographic operations.
> DUN is stored in 'bi_dun' of bi_iter as a specific value for each BIO.
> 
> Before attempting to merge the two BIOs, the operation is also added to
> verify that the crypto information contained in two BIOs is consistent.

This isn't going to happen. With this, and the inline encryption
proposed by Google, we'll bloat the bio even more. At least the Google
approach didn't include bio iter changes as well.

Please work it out between yourselves so we can have a single, clean
abstraction that works for both.

-- 
Jens Axboe

