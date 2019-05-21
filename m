Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BB37C04AAF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 07:38:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A25D21019
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 07:38:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nqw8oc68"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727052AbfEUHij (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 03:38:39 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46978 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726006AbfEUHii (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 03:38:38 -0400
Received: by mail-wr1-f68.google.com with SMTP id r7so17270170wrr.13;
        Tue, 21 May 2019 00:38:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=5ryJbbZodXACWTO9xzLjJVVDfVukY2SjZqE/RR5ZRyY=;
        b=nqw8oc680iMAXhEvqTRlU54E1joqR2AvVBhvZfLCL7BBx/cJuYXEsr2tIKWi9s/noe
         OyAh63/DLuZBsMo4BQnTIiH7d2J3BTTStDZ11VOlWi6H4zlhecsZStdaOK9Y/gUzRgcj
         7SLMARSMr3T9KqOGhrDNMx8/4OdVO6LE2S1HO/maHyEHUbEHu9/H6GWOkYa6upqiwApD
         Ys5KRsRW9HudhzP/+KX9j1ouXQsqo0IdByIvhVy2ZWMEtNnWtMiPZA/xxFeFKc56E5zH
         4RbOk04KtUI/edTwJzfndt6RAb47JGe5IUqvSXD3ZKeEIlLc0NeynN1bNwcoj9tjOb4x
         xXbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5ryJbbZodXACWTO9xzLjJVVDfVukY2SjZqE/RR5ZRyY=;
        b=rIk/juNHOGO4R6U4lq4A/nw9k3zT15uuE8dvfRE26lmIzylSfIUFjMeIHdbWvO6qwA
         bK5ggfGExwXI5k2JiThIni+2lFenQxvBFCgUgXQIvOO+HjadmmmMyMz58Z/AxZOUBl/v
         DTuB830xGjnAc5p8GXBelQETnQWwdHhybnsyRYRX6ztP9dXDs8mb6pgx0pxnMFNJmoWy
         ako96+pfiB+wOspdqIe7QFi1ZhF6+IKNcRFT+NqNnd+tX9GEYDa2amUI8p+EQkVLX5jP
         9PTBisJEfGEZ9xL1tejn9ZOUrtnVOhAxWHQuPjkyc56hr3LO6CsRYsN7xJMtoIVp22df
         UfVQ==
X-Gm-Message-State: APjAAAXYhszrq01JE45z7uDkgLpfHRnEtB2Wn7uaL7N+/tBtFSCp5R8x
        EQHvFahiqyCBOmT0Ka4fPr/ML6cnJG4=
X-Google-Smtp-Source: APXvYqwfLIm49NnDDXdp9jn68Vl7JSM+PaLLfYbbHu9fobHWezVc5/071lrqi5iSH9Bh8drGE7n0mA==
X-Received: by 2002:a5d:4002:: with SMTP id n2mr13890891wrp.187.1558424316584;
        Tue, 21 May 2019 00:38:36 -0700 (PDT)
Received: from [10.43.17.31] (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id a10sm23974617wrm.94.2019.05.21.00.38.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 May 2019 00:38:36 -0700 (PDT)
Subject: Re: [RFC 1/1] Add dm verity root hash pkcs7 sig validation.
To:     Jaskaran Khurana <jaskarankhurana@linux.microsoft.com>,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     agk@redhat.com, snitzer@redhat.com, dm-devel@redhat.com,
        jmorris@namei.org
References: <20190520215422.23939-1-jaskarankhurana@linux.microsoft.com>
 <20190520215422.23939-2-jaskarankhurana@linux.microsoft.com>
From:   Milan Broz <gmazyland@gmail.com>
Openpgp: preference=signencrypt
Message-ID: <7e922983-7716-e215-a29b-3154f7afb493@gmail.com>
Date:   Tue, 21 May 2019 09:38:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190520215422.23939-2-jaskarankhurana@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/05/2019 23:54, Jaskaran Khurana wrote:
> Adds in-kernel pkcs7 signature checking for the roothash of
> the dm-verity hash tree.
> 
> The verification is to support cases where the roothash is not secured by
> Trusted Boot, UEFI Secureboot or similar technologies.
> One of the use cases for this is for dm-verity volumes mounted after boot,
> the root hash provided during the creation of the dm-verity volume has to
> be secure and thus in-kernel validation implemented here will be used
> before we trust the root hash and allow the block device to be created.
> 
> The signature being provided for verification must verify the root hash and 
> must be trusted by the builtin keyring for verification to succeed.
> 
> Adds DM_VERITY_VERIFY_ROOTHASH_SIG: roothash verification
> against the roothash signature file *if* specified, if signature file is
> specified verification must succeed prior to creation of device mapper 
> block device.
> 
> Adds DM_VERITY_VERIFY_ROOTHASH_SIG_FORCE: roothash signature *must* be
> specified for all dm verity volumes and verification must succeed prior
> to creation of device mapper block device.

I am not sure this is a good idea. If I understand it correctly, this will
block creating another dm-verity mappings without PKCS7 signature, and these
are used in many other environments and applications that could possibly
run on that system later.

(But I have no idea how to solve it better though :-)

...

> +	/* Root hash signature is  a optional parameter*/
> +	r = verity_verify_root_hash(root_hash_digest_to_validate,
> +				    strlen(root_hash_digest_to_validate),
> +				    verify_args.sig,
> +				    verify_args.sig_size);
> +	if (r < 0) {
> +		ti->error = "Root hash verification failed";
> +		goto bad;
> +	}

You are sending the PKCS7 signature as a (quite large) binary blob inside the mapping table.

I am not sure if it is possible here (I guess so), but why not put this it kernel keyring
and then just reference it from mapping table?
(We use kernel keyring in libcryptsetup already for dm-crypt.)

It will also solve an issue in userspace patch, when you are reading the signature
file too late (devices can be suspended in that moment, so I would prefer to download
sig file to keyring in advance, and then just reference it in mapping table).

(I guess you will send merge request for veritysetup userspace part later.)

Milan
