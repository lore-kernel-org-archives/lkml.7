Return-Path: <SRS0=M1fl=TR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C16C9C04AB4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 21:17:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E5282087B
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 21:17:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=landley-net.20150623.gappssmtp.com header.i=@landley-net.20150623.gappssmtp.com header.b="HwpC4RrW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728654AbfEQVQ7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 May 2019 17:16:59 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:36897 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726771AbfEQVQ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 17:16:57 -0400
Received: by mail-oi1-f196.google.com with SMTP id f4so6195978oib.4
        for <linux-kernel@vger.kernel.org>; Fri, 17 May 2019 14:16:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=landley-net.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=E2H9E8ynXEsa3QuvJM4S/38HaYT5LjHH75EOqiq4bas=;
        b=HwpC4RrWhmVT2sRECgJy6qj4/VU5z3EioWa4gwjjVsUl7jx0XN/rPuOnEi6NhYrZ2p
         F1zjTFDItG03H+5lRuQ6zyijuZDYz9b+wXrJyshH+ix8Vfmvxo5/vcTrWlI4n5tnBiWx
         8LnqSWEna/zgdRZlB569dAnzMWBe1JzuL1m6C+p21hStLtZyu2JAiXnVe0VAQ7kn6LsK
         E4WyjiheJBZrsyo2mI2o+hmJr4ceNC+4/Rs6tvPC4bweoNEYcXUXDGjVlJTy6mZKTHXu
         jOucgFyRAwEUEsOPgwJcwAHcOsLwmGWLDUCDsO4Vr8KrVNIa7uplWoeTca22GrU9TLrt
         GN+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=E2H9E8ynXEsa3QuvJM4S/38HaYT5LjHH75EOqiq4bas=;
        b=jcuH90FFPc5ZLoqJoPEswcN+Wa+HvKqHLI/CZxWQQ3k64yVnVUgnsXZr5JuBh/LfqP
         67fiNnLEfwd4NDXo35iPgKcYtS1srLw5uZyKRDc4S8Ox0yhcF6Vom/XFDiIycWG0bg3q
         UGf8K7CfDCwvowxi5yCV5uRkO0jWhGt638IYsuYoopoFEOXxyBJj3gIrpZRjSEnnmrnd
         tPH1FMT7croJ2/go9B5VUNEk2X62cLy2a7DuUuJijP8kjb0MApgKx9e+O09MBhCHp61e
         NqOde7esJbHqYS4MkWnLjb+OnkvFC+btIHsSHyZx4/ql1CBAIdFgjqLldpjlqFWN7k/r
         BD6A==
X-Gm-Message-State: APjAAAWynTxuEQGZI1Agzj/6ZzRhjBbPlFZ7SC098gqXvFEBxuwoI/+A
        wHS5v4R4O1gMq02hF2XjIy8NAQ==
X-Google-Smtp-Source: APXvYqySaxA8Ue4p1Miit+toZFZg3BakSoFRI3b4Xx15JMWDxpnkVOH27XxQnYKZoy9nFEinxmBHqA==
X-Received: by 2002:a05:6808:a08:: with SMTP id n8mr11031oij.20.1558127816024;
        Fri, 17 May 2019 14:16:56 -0700 (PDT)
Received: from [192.168.1.5] (072-182-052-210.res.spectrum.com. [72.182.52.210])
        by smtp.googlemail.com with ESMTPSA id g102sm3352444otg.59.2019.05.17.14.16.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 May 2019 14:16:55 -0700 (PDT)
Subject: Re: [PATCH v3 2/2] initramfs: introduce do_readxattrs()
To:     hpa@zytor.com, Roberto Sassu <roberto.sassu@huawei.com>,
        viro@zeniv.linux.org.uk
Cc:     linux-security-module@vger.kernel.org,
        linux-integrity@vger.kernel.org, initramfs@vger.kernel.org,
        linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, zohar@linux.vnet.ibm.com,
        silviu.vlasceanu@huawei.com, dmitry.kasatkin@huawei.com,
        takondra@cisco.com, kamensky@cisco.com, arnd@arndb.de,
        james.w.mcmechan@gmail.com, niveditas98@gmail.com
References: <20190517165519.11507-1-roberto.sassu@huawei.com>
 <20190517165519.11507-3-roberto.sassu@huawei.com>
 <CD9A4F89-7CA5-4329-A06A-F8DEB87905A5@zytor.com>
From:   Rob Landley <rob@landley.net>
Message-ID: <591c0770-7a82-3d45-e5b2-7ed347db812a@landley.net>
Date:   Fri, 17 May 2019 16:17:31 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CD9A4F89-7CA5-4329-A06A-F8DEB87905A5@zytor.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/17/19 3:18 PM, hpa@zytor.com wrote:
> Ok... I just realized this does not work for a modular initramfs, composed at load time from multiple files, which is a very real problem. Should be easy enough to deal with: instead of one large file, use one companion file per source file, perhaps something like filename..xattrs (suggesting double dots to make it less likely to conflict with a "real" file.) No leading dot, as it makes it more likely that archivers will sort them before the file proper.
> 
> A side benefit is that the format can be simpler as there is no need to encode the filename.
> 
> A technically cleaner solution still, but which would need archiver modifications, would be to encode the xattrs as an optionally nameless file (just an empty string) with a new file mode value, immediately following the original file. The advantage there is that the archiver itself could support xattrs and other extended metadata (which has been requested elsewhere); the disadvantage obviously is that that it requires new support in the archiver. However, at least it ought to be simpler since it is still a higher protocol level than the cpio archive itself.
> 
> There's already one special case in cpio, which is the "!!!TRAILER!!!" filename; although I don't think it is part of the formal spec, to the extent there is one, I would expect that in practice it is always encoded with a mode of 0, which incidentally could be used to unbreak the case where such a filename actually exists. So one way to support such extended metadata would be to set mode to 0 and use the filename to encode the type of metadata. I wonder how existing GNU or BSD cpio (the BSD one is better maintained these days) would deal with reading such a file; it would at least not be a regression if it just read it still, possibly with warnings. It could also be possible to use bits 17:16 in the mode, which are traditionally always zero (mode_t being 16 bits), but I believe are present in most or all of the cpio formats for historical reasons. It might be accepted better by existing implementations to use one of these high bits combined with S_IFREG, I dont know.
> 

I'll happily modify toybox cpio to understand xattrs (compress and decompress),
the android guys do a lot with xattrs already. I tapped out of _this_ discussion
from disgust with the proposed encoding.

Rob
