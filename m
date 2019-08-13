Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FA7FC433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 09:12:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5A3520679
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 09:12:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hfRt+z+D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727502AbfHMJMe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 05:12:34 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:37944 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726974AbfHMJMe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 05:12:34 -0400
Received: by mail-lj1-f196.google.com with SMTP id r9so100863346ljg.5
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2019 02:12:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Fqm1qEXgId3LWA2NcOGNLytQeIXWcu4whGK205OK+oE=;
        b=hfRt+z+D9yk1sJYudtDMXBHyY6D+2qiqV/Q0A5uC517NkQfhn84w03CEm+CUmcg/YO
         xJPqvrGgLs16lDH/3dloHHlkGbp2h3r9rIgnDvmKfVTplppEulAeS2WQtVGZ8wWFs15M
         R5qBYokxyKXI2Jfql/W33mwqvH+OuFprJVGNGTsHQu5VItj8aJMS6Ur6rJYb6Hy7WRn/
         AX4hDuDNWmPdJr+yZFLhP6VsHFefhVLaK4WsyRhEk2D+tu0eVkerETdtQ8N8zpk4CR7G
         z7+Z3ORP+em5lWvkHic+zqfbFKZVaZBuXDwrPHPXLdvyLr95YD3Zita8cZ6CQHogX55V
         lS0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=Fqm1qEXgId3LWA2NcOGNLytQeIXWcu4whGK205OK+oE=;
        b=av1fwLR9TQhRjBckvjzlxhPhcphS7vfv3QWwuUc8H6BtzE0N1BRgnQuSFJM/MpzCeh
         U6LYy4WDfxdfqz0BYsx1GyDUbaKymDbuMPhzlJ/T/0kjPoEjyeemklXH9i0vYEBdjYXe
         3G7vvVWmzgnq4qo8atQVTwDFPu0TGfvgCw/QKXGLBGBAiFeAgLXTusI1dIMJcaEfQgb5
         1by05FZ0tnCQ8Kf9y44pevRPp1pOdLDZ/S3ySDJjZJ4/C7LO7a5JNRb0b9R+slnSz/XQ
         UgMGpBaCV8jqdhnBC79xKp2Hq0yC7HtEMdLO9BpJKT9VM3NHrhXINzByQTymi4lNT3+P
         4MwQ==
X-Gm-Message-State: APjAAAV90UihFgfs55ApArZWXux0HmrtpJBe3cFjPfKVEjAKftskteBQ
        Jad0SpWtYdxiDfT64r/gYvw69w==
X-Google-Smtp-Source: APXvYqyEmjV0GBixJh0DVshdyHJJIKyBEfQHcoHLxMsbb6J1S0HM71TOzoTAcNAvNIqYowflXLcs+w==
X-Received: by 2002:a2e:3a13:: with SMTP id h19mr20948011lja.220.1565687552537;
        Tue, 13 Aug 2019 02:12:32 -0700 (PDT)
Received: from khorivan (168-200-94-178.pool.ukrtel.net. [178.94.200.168])
        by smtp.gmail.com with ESMTPSA id l23sm21497274lje.106.2019.08.13.02.12.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 13 Aug 2019 02:12:31 -0700 (PDT)
Date:   Tue, 13 Aug 2019 12:12:29 +0300
From:   Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
To:     Magnus Karlsson <magnus.karlsson@gmail.com>
Cc:     =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn.topel@intel.com>,
        linux-mm@kvack.org, Xdp <xdp-newbies@vger.kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, Alexei Starovoitov <ast@kernel.org>,
        "Karlsson, Magnus" <magnus.karlsson@intel.com>
Subject: Re: [PATCH v2 bpf-next] mm: mmap: increase sockets maximum memory
 size pgoff for 32bits
Message-ID: <20190813091228.GA6951@khorivan>
Mail-Followup-To: Magnus Karlsson <magnus.karlsson@gmail.com>,
        =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn.topel@intel.com>,
        linux-mm@kvack.org, Xdp <xdp-newbies@vger.kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, Alexei Starovoitov <ast@kernel.org>,
        "Karlsson, Magnus" <magnus.karlsson@intel.com>
References: <20190812113429.2488-1-ivan.khoronzhuk@linaro.org>
 <20190812124326.32146-1-ivan.khoronzhuk@linaro.org>
 <CAJ8uoz0bBhdQSocQz8Y9tvrGCsCE9TDf3m1u6=sL4Eo5tZ17YQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CAJ8uoz0bBhdQSocQz8Y9tvrGCsCE9TDf3m1u6=sL4Eo5tZ17YQ@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 13, 2019 at 10:02:54AM +0200, Magnus Karlsson wrote:
>On Mon, Aug 12, 2019 at 2:45 PM Ivan Khoronzhuk
><ivan.khoronzhuk@linaro.org> wrote:
>>
>> The AF_XDP sockets umem mapping interface uses XDP_UMEM_PGOFF_FILL_RING
>> and XDP_UMEM_PGOFF_COMPLETION_RING offsets. The offsets seems like are
>> established already and are part of configuration interface.
>>
>> But for 32-bit systems, while AF_XDP socket configuration, the values
>> are to large to pass maximum allowed file size verification.
>> The offsets can be tuned ofc, but instead of changing existent
>> interface - extend max allowed file size for sockets.
>
>Can you use mmap2() instead that takes a larger offset (2^44) even on
>32-bit systems?

That's for mmap2.

>
>/Magnus
>
>> Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
>> ---
>>
>> Based on bpf-next/master
>>
>> v2..v1:
>>         removed not necessarily #ifdev as ULL and UL for 64 has same size
>>
>>  mm/mmap.c | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/mm/mmap.c b/mm/mmap.c
>> index 7e8c3e8ae75f..578f52812361 100644
>> --- a/mm/mmap.c
>> +++ b/mm/mmap.c
>> @@ -1358,6 +1358,9 @@ static inline u64 file_mmap_size_max(struct file *file, struct inode *inode)
>>         if (S_ISBLK(inode->i_mode))
>>                 return MAX_LFS_FILESIZE;
>>
>> +       if (S_ISSOCK(inode->i_mode))
>> +               return MAX_LFS_FILESIZE;
>> +
>>         /* Special "we do even unsigned file positions" case */
>>         if (file->f_mode & FMODE_UNSIGNED_OFFSET)
>>                 return 0;
>> --
>> 2.17.1
>>

-- 
Regards,
Ivan Khoronzhuk
