Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AE6CC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 14:59:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C994B2075C
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 14:59:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Trjj+fhV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731876AbfCZO7o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 10:59:44 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:35365 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731560AbfCZO7o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 10:59:44 -0400
Received: by mail-oi1-f194.google.com with SMTP id j132so10167731oib.2;
        Tue, 26 Mar 2019 07:59:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=8wwF1Uj+yImZjtOKtUto86IZVVFBUmGwSkNQZRG7bw8=;
        b=Trjj+fhVSMvbdWAs5ITR336WKS5kykuDK2OzQCdwr5JZNc2lUFxS1awa3vRh/3+BN0
         TlhUF9BUrVGOeboInk0/pOHhT2jzHwOLL5r5/TH2I2XU3fWKwCZka0uveYfz9QkDQ7E3
         XX1GsNz7DTjBCFJNrXHxvpJq30CBielTdvoUJGx1PHwe0XzWtHHmNom/S+8UJguks0kR
         FWEQWxOK8aWtVcL2ZdocdcSOewKCYR5tFbBgKBHpJmD+pKgU5k62zuHbUxRsN3T/qFyw
         uFlRDPudajPtmmKRC1JkonMZJLnvUNfUKwu6R05FNBvbnJzeyuPDDxG8NsmdLW5RuY94
         sTRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8wwF1Uj+yImZjtOKtUto86IZVVFBUmGwSkNQZRG7bw8=;
        b=mXwpAGJzCPGtH1kp/vk4CVaSKFlENmQblkrf0RsN6M95AN+PY0buaeuhJtONhCxkyN
         k5kNA6Bea6TkEXpm6Ba2tXAVFpD4VQFJ+JuQ//Knus5hteODXESAqq0Na9iHisVz0Gb8
         f01Zr490ZK+h12hIX1XHIwy3cd8KrcM4HQ/6H3/ldx9uZRoWonk/CETIMVbDS1x5LCXz
         7Iy2GxZd1EYhnspVKgaT9prjon8pEcbZeqVR1AnnqBaTiMu6ASVzImZYTMYFHcMUr3ET
         2L3vAiDEeJBd2A3un5iT0fiCoTNRJuavgffGmrkpPrkV6s3iJDdHYS3LmZ14LKlupBCm
         6zlw==
X-Gm-Message-State: APjAAAUEj+4wza5OK72waHSpMZbzJlItB2BdV5BYehoIyGKFxe5BN5wX
        zeZ09NkQYRcivhlz8RAKyxs=
X-Google-Smtp-Source: APXvYqwJhGmoX+qubeZuS96wppA75ntlCZcroJBS2l6uNUPszX4ridHlNLKZFcoqO53jl4I4qoD+DQ==
X-Received: by 2002:aca:4bc8:: with SMTP id y191mr15318036oia.94.1553612383373;
        Tue, 26 Mar 2019 07:59:43 -0700 (PDT)
Received: from [192.168.1.249] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id o83sm6344955oif.33.2019.03.26.07.59.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Mar 2019 07:59:41 -0700 (PDT)
Subject: Re: Bad file pattern in MAINTAINERS section 'KEYS-TRUSTED'
To:     James Bottomley <jejb@linux.ibm.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Joe Perches <joe@perches.com>
Cc:     linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        keyrings@vger.kernel.org, Mimi Zohar <zohar@us.ibm.com>,
        David Howells <dhowells@redhat.com>,
        James Morris <jmorris@namei.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        James Morris <james.morris@microsoft.com>
References: <7cd8d12f59bcacd18a78f599b46dac555f7f16c0.camel@perches.com>
 <20190325212705.26837-1-joe@perches.com>
 <20190326113725.GA10898@linux.intel.com>
 <1553602220.3960.29.camel@linux.ibm.com>
 <1553610317.2900.2.camel@linux.ibm.com>
From:   Denis Kenzior <denkenz@gmail.com>
Message-ID: <c7f70a06-65a5-a1cd-69c5-dae7567b851f@gmail.com>
Date:   Tue, 26 Mar 2019 09:59:40 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <1553610317.2900.2.camel@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

On 03/26/2019 09:25 AM, James Bottomley wrote:
> Looking at the contents of linux/keys/trusted.h, it looks like the
> wrong decision to move it.  The contents are way too improperly named
> and duplicative to be in a standard header.  It's mostly actually TPM
> code including a redefinition of the tpm_buf structure, so it doesn't
> even seem to be necessary for trusted keys.
The reason this was done was because asym_tpm.c needed a bunch of the 
same functionality already provided by trusted.c, e.g. TSS_authmac and 
friends.

> 
> If you want to fix this as a bug, I'd move it back again, but long term
> I think it should simply be combined with trusted.c because nothing
> else can include it sanely anyway.

Ideally I'd like to see the TPM subsystem expose these functions using 
some proper API / library abstraction.  David Howells had an RFC patch 
set that tried to address some of this a while back.  Not sure if that 
went anywhere.

Regards,
-Denis
