Return-Path: <SRS0=U1ji=ZC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9948AC43331
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Nov 2019 20:58:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 686152077C
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Nov 2019 20:58:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C3ILoU5R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727030AbfKJU6T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Nov 2019 15:58:19 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:40705 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726800AbfKJU6T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Nov 2019 15:58:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573419496;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:openpgp:openpgp;
        bh=1qTjdfC8ezIAZIrpn04RQSW87KvIrvGlilpBXh6ye9k=;
        b=C3ILoU5RtTqtP+qBL8g+mt+JKek3bqeKNQ2PF/CoPjVUB6pGDvflo7aSHSMhVBqtz7+Z1g
        cm9jccOlkUIYs/4QkyHRWHrajc/fuMqrvagjNY0imGzCmD8PfRoQvi95prC10NQl1IkPK6
        Z6KFZBRAfzv/qRvHQAezA8ZNYDrEMXg=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-320-coam3oU4NVqku1dfQG1Njg-1; Sun, 10 Nov 2019 15:58:15 -0500
Received: by mail-wr1-f69.google.com with SMTP id k15so1064259wrp.22
        for <linux-kernel@vger.kernel.org>; Sun, 10 Nov 2019 12:58:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7F8iE9QzmCtoPp4QzWe8QlpBFqJv960okC23ay4RuRU=;
        b=f8b/lracZsk7onm/m3UJf900u/sCg1A5NDLztohC/TXrP54VSduSjYUiCdshplXCol
         ZX+NpwSYVFmU35H6fCfhBMFj5RC4u6nV80lum0k6U422PcRugydb6Fr+GIKkOyw6ZNiA
         +KnrC8nG14rn57XAZfPCvwx2Gvq9khOSJUTIgW4h+uqmyB57nf+urNvBCaqZi73mhhTG
         AbEhUYQjt0wPsjAk4MDyeyTHBkckFlLksWB6oBAT/B5SrqHJY51/EbItpsjEidi3odwL
         JmpTZE+wWK2MhqxpArL1vwhm6RMVBZVy/XliYZsoPwkem/4U38OypzhW7m3squrHdkZb
         hnbw==
X-Gm-Message-State: APjAAAVdctnxUxcmedVnDEqydAVjaqeENd+teIevYo49O1tezv9+8VB9
        LoinirMOzLJioEuXESQikvkG3AXHS6pQGhumuw/3a3BECm503u99lU/78oDOwDN6miLYx3JohOY
        2B5Pq9zt6pgsrR5Y/4drWU8TN
X-Received: by 2002:a1c:e0c4:: with SMTP id x187mr18345175wmg.93.1573419494262;
        Sun, 10 Nov 2019 12:58:14 -0800 (PST)
X-Google-Smtp-Source: APXvYqz5Shc4FEqXb6AMBAG6avRltInuQ7VAj50rA6or0wKrTsT41F9rt48W7L7rXTaeYs4BbD8jNQ==
X-Received: by 2002:a1c:e0c4:: with SMTP id x187mr18345162wmg.93.1573419493959;
        Sun, 10 Nov 2019 12:58:13 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:e8cd:9f0f:a5dc:7ad5? ([2001:b07:6468:f312:e8cd:9f0f:a5dc:7ad5])
        by smtp.gmail.com with ESMTPSA id 76sm18841698wma.0.2019.11.10.12.58.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 10 Nov 2019 12:58:13 -0800 (PST)
Subject: Re: "statsfs" API design
To:     Alexey Dobriyan <adobriyan@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org
References: <20191109184441.GA5092@avx2> <20191110091435.GC1435668@kroah.com>
 <20191110153424.GA5141@avx2>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <9fe3a096-20b9-979a-d4d7-48a37b059dff@redhat.com>
Date:   Sun, 10 Nov 2019 21:58:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191110153424.GA5141@avx2>
Content-Language: en-US
X-MC-Unique: coam3oU4NVqku1dfQG1Njg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/11/19 16:34, Alexey Dobriyan wrote:
> In the other direction: describe every field of /proc/*/stat file
> without looking to the manpage:
>=20
> $ cat /proc/self/stat
> 5349 (cat) R 5342 5349 5342 34826 5349 4210688 91 0 0 0 0 0 0 0 20 0 1 0 =
864988 9183232 184 18446744073709551615 94352028622848 94352028651936 14073=
3810522864 0 0 0 0 0 0 0 0 0 17 5 0 0 0 0 0 94352030751824 94352030753376 9=
4352060055552 140733810527527 140733810527547 140733810527547 1407338105323=
35 0

That's why this is not what I am proposing, and also not what Greg has
mentioned.

> and realise that everything alse is a waste of electricity, namely,
>=20
> * pathname allocation (4KB)
> * VFS '/' split, lookups (/sys/kernel/.../" means 3+ lookups
> * 192 bytes for each dentry
> * 550+ bytes per inode
> * 3 system calls per act of gathering statistics
> =09userspace will be written in the most stupid way possible
> =09without openat() etc
> * userspace snprintf() for pathname
> * kernel space snprintf() somewhere
> * multiple copying inside kernel (vsnprintf.c)
> * general inability for userspace to estimate the amount of data in decim=
al
>   (nobody does that), so nicely sized buffers of 4K or 1K or 16KB (bash)
>   will be used which is a waste.

Yeah, all of this is true but I know how much I use
/sys/kernel/debug/kvm so backwards-compatibility with it is certainly a
requirement for stats.  Good thing, having a high-level stats API lets
you also design something that targets different usecases than just
quick "cat" or "watch".  The somewhat wasteful sysfs interface to
statsfs can even be hidden behind a kconfig symbol once there is an
alternative.  It also makes it possible to create inodes on demand if
someone is so inclined.

So the good thing is that despite the disagreements, this can be
considered an argument in favor of statsfs, and we agree on that. :)

Thanks,

Paolo

