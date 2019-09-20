Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71B7DC3A5A2
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 19:21:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45C9C205F4
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 19:21:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a3VFKP3p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726442AbfITTVi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 15:21:38 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:41685 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725869AbfITTVi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 15:21:38 -0400
Received: by mail-wr1-f68.google.com with SMTP id h7so7864370wrw.8
        for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2019 12:21:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=PJyeClMQVfNi5aFiPW4+LQNcu88byDAQ1TqGQo4z/1g=;
        b=a3VFKP3pP7MsgoR9+U3VItQ4jCWJoGV9jijSEb+eqgTlAziNCCnavHxtgIFsD5J95R
         g/cCazSjQSATWLk0WQEygPus1eLmpmmfRaw1bYPrh6OI5CGl3HB65VzcLNMDcEIk690x
         8B5uS9XkRPcKshYWtDUR5DyJ1dZGPD2JjFeY4PEKM9J6xg0Yp9Bzn3Kl3Ofli6LThZXx
         NHZkfo903VKQS/izbH1VPZTgb5gNPYBkesO0p4bO8ubWOmKDaqxdAoUBTcyWgaTycd8s
         ROznvdCjMZdGL2EOcBN1jlgyYbRASLU0gv/+7ZIBchCqwYQrvJDQjdoazEv7kBFZpabQ
         HsAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=PJyeClMQVfNi5aFiPW4+LQNcu88byDAQ1TqGQo4z/1g=;
        b=L5IztBSFpbIZs9Lg//4EEANZ2zVQgrL8vGX7rsMxAzZxBMTh7fxtP+2t+l7UNrdXk5
         a6NbZpSA8VZqORNR5nbNWCuKb7ZmfJ1XuUEUYyB88YBn8SgIZgzDY05wde2ZDuq9xOwT
         NU7mxdY35PaUUry9FAAFgflJeYKqITQfeEP5pk9bOX5Q+u6ancC952gwmP3wjlUo3V4d
         8CGReBwsoYs0ApPjl6zzyIy2tb7XHnvyF230OQUubAgieUMbyXV6d2MMTcqe0rP+ZabY
         CzUdwu32PS+TyIy85oiiqDOfU9lo79mgFpp8id8HwKRQX9GZYSFn2lLv8Nbd12xxjZ/V
         4cHw==
X-Gm-Message-State: APjAAAVYdKjL82wwWQMgwjVcznV/Rqsw6f0xJ2h50kfNjoDJOwfCmdbU
        Ik//YDNwJGV6tIeQlFPtnSU2P1bA
X-Google-Smtp-Source: APXvYqziOU8XeRx1ViKOkNnAeYNxQKqLPgBJKUiE52oKkbZ40GHXI1ev8ZeIJvOvn1qG3Edkg03rmA==
X-Received: by 2002:a5d:5352:: with SMTP id t18mr13608922wrv.72.1569007295889;
        Fri, 20 Sep 2019 12:21:35 -0700 (PDT)
Received: from [192.168.2.28] (39.35.broadband4.iol.cz. [85.71.35.39])
        by smtp.gmail.com with ESMTPSA id o9sm4917013wrh.46.2019.09.20.12.21.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Sep 2019 12:21:35 -0700 (PDT)
Subject: Re: dm-crypt error when CONFIG_CRYPTO_AUTHENC is disabled
To:     Mike Snitzer <snitzer@redhat.com>,
        Thibaut Sautereau <thibaut.sautereau@clip-os.org>
Cc:     dm-devel@redhat.com, Alasdair Kergon <agk@redhat.com>,
        linux-kernel@vger.kernel.org
References: <20190920154434.GA923@gandi.net>
 <20190920173707.GA21143@redhat.com>
From:   Milan Broz <gmazyland@gmail.com>
Openpgp: preference=signencrypt
Message-ID: <13e25b01-f344-ea1d-8f6c-9d0a60eb1e0f@gmail.com>
Date:   Fri, 20 Sep 2019 21:21:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20190920173707.GA21143@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/09/2019 19:37, Mike Snitzer wrote:
> On Fri, Sep 20 2019 at 11:44am -0400,
> Thibaut Sautereau <thibaut.sautereau@clip-os.org> wrote:
> 
>> Hi,
>>
>> I just got a dm-crypt "crypt: Error allocating crypto tfm" error when
>> trying to "cryptsetup open" a volume. I found out that it was only
>> happening when I disabled CONFIG_CRYPTO_AUTHENC.
>>
>> drivers/md/dm-crypt.c includes the crypto/authenc.h header and seems to
>> use some CRYPTO_AUTHENC-related stuff. Therefore, shouldn't
>> CONFIG_DM_CRYPT select CONFIG_CRYPTO_AUTHENC?
> 
> Yes, it looks like commit ef43aa38063a6 ("dm crypt: add cryptographic
> data integrity protection (authenticated encryption)") should've added
> 'select CRYPTO_AUTHENC' to dm-crypt's Kconfig.  I'll let Milan weigh-in
> but that seems like the right way forward.

No, I don't this so. It is like you use some algorithm that is just not compiled-in,
or it is disabled in the current state (because of FIPS mode od so) - it fails
to initialize it.

I think we should not force dm-crypt to depend on AEAD - most users
do not use authenticated encryption, it is perfectly ok to keep this compiled out.

I do not see any principal difference from disabling any other crypto
(if you disable XTS mode, it fails to open device that uses it).

IMO the current config dependence is ok.

Milan
