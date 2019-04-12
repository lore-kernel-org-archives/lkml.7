Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F560C10F14
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 18:08:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDD7120850
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 18:08:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P2JCywJY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726993AbfDLSIq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 14:08:46 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:41111 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726685AbfDLSIp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 14:08:45 -0400
Received: by mail-pl1-f196.google.com with SMTP id d1so5490229plj.8;
        Fri, 12 Apr 2019 11:08:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=HhLcNdhBqcPguTAW0qLxSTBSD9WCe7On19c9LCgp5e4=;
        b=P2JCywJYIrBBLpq9ocHi/pxi7p1dvfDqJAMnvLQBRx8cLcxKOyAj9b57gpVylNsJAC
         cHr4nVn3daCJo50ELRKN65K4H2d5NrMkOgR2e8PqDtLqZ6Ht9dm1uNYdd3PH08ay+LZT
         HU5/xTAuPI4B5dFg1paYjauksnf/6tjZvV/vr3CEBEUrdCsN9l1qsSDfFRLj1Ov/r63Q
         9fr13DdEeClT/N4Pr4sCnnco3YMsKE9gDjuJ0l76NoxsDXkMoEvutEmOX6j448j0EzPy
         chCVUl53+GqrMF/j13qEgOCbkI7tEawgqXB8sLrQZcxV75XYVNv3xoy7BBCiMm0D5osf
         bZ1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HhLcNdhBqcPguTAW0qLxSTBSD9WCe7On19c9LCgp5e4=;
        b=TE0hbex5i53TlzinynaJwXXrjia7LTMQDDp1YNayk4vUhn/ZFW77Gep2DtN2n/xCbh
         Zq8tBYOC93iDHQs7+Tm+GaJA6z/WyKL3Nb5AdWC9nAJ6794dyPINMJjCRyFa/B8nnvpj
         fGaPKdEnpCkTuu8HtLm18TNeqdFFaTmdB0qPkJJD1SJQV8eMMWrdC/fT5EmKIfX4QDtm
         2eA3w49N6JezeXIfiOf2vPRUwXk+mjAT17dpw/nOA5wQ1IPVY5Yi7TaPR/vEnq0Nhb77
         ELzYMRtfLIJ7iTNfxY2SS4BQSoQ82Xo9t0yIKSjwUJnQ92AbeCUSJTAUmDqX0ngXXFCZ
         K98g==
X-Gm-Message-State: APjAAAXhQp6/CToUJEKZOREhDINOLQdWvyXoSBS2SJduDDeaUEm/JIJG
        M92vSL/IvqGwi2kKQLepasUVhQyL
X-Google-Smtp-Source: APXvYqxBHY1YJ1LAX2zuP54uh6horpzZHUDMMxu+toU3D5EN6JoHTzF7lS8XVDtxDEnw/gfN9/qGkA==
X-Received: by 2002:a17:902:9884:: with SMTP id s4mr59006013plp.179.1555092524306;
        Fri, 12 Apr 2019 11:08:44 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id l74sm67744857pfi.174.2019.04.12.11.08.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Apr 2019 11:08:43 -0700 (PDT)
Subject: Re: [PATCH 0/5] Fix rhashtable bit-locking for m68k
To:     NeilBrown <neilb@suse.com>, Thomas Graf <tgraf@suug.ch>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        David Miller <davem@davemloft.net>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <155503371949.17793.8266195008003399968.stgit@noble.brown>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <db89e10c-44ba-117d-2fe3-e01eb733d29a@roeck-us.net>
Date:   Fri, 12 Apr 2019 11:08:41 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <155503371949.17793.8266195008003399968.stgit@noble.brown>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/11/19 6:52 PM, NeilBrown wrote:
> As reported by Guenter Roeck, the new rhashtable bit-locking
> doesn't work on m68k as it only requires 2-byte alignment, so BIT(1)
> is addresses is not unused.
> 
> We current use BIT(0) to identify a NULLS marker, but that is only
> needed in ->next pointers.  The bucket head does not need a NULLS
> marker, so the lsb there can be used for locking.
> 
> the first 4 patches make some small improvements and re-arrange some
> code.  The final patch converts to using only BIT(0) for these two
> different special purposes.
> 
> I had previously suggested dropping the series until I fix it.  Given
> that this was fairly easy, I retract that I think it best simply to
> add these patches to fix the code.
> 
For the series:

Tested-by: Guenter Roeck <linux@roeck-us.net>

Tested with the series applied on top of next-20190412, running all
345 qemu tests. No boot failures or new warnings observed.

Guenter
