Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBFE6C10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 14:28:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B75AE20835
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 14:28:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389398AbfDRO2T convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 10:28:19 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:43178 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389258AbfDRO2T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 10:28:19 -0400
Received: by mail-pl1-f195.google.com with SMTP id n8so1247670plp.10
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2019 07:28:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:user-agent:in-reply-to:references
         :mime-version:content-transfer-encoding:subject:to:cc:from
         :message-id;
        bh=iY11L4FnZ0bdBG/SRDQrmyEHylklCDemsvSEJjdMFaM=;
        b=fTF8ijNjxWm+8EtHoxm4yA+NIHZgZJYzhMfg8X2U+Dfgw/8d5OJ0wxZg8KtjNjl1xR
         aAKUhoM73jILEIFjXseENyoAa+qUDEmxyJEf1oqrkhr5nRlEDRMdqhs6ERzcLTVJXhqa
         os35Gc6UERJEtGyGKxMSikfcME03Vegq13cU/l94RjYOY5ntxbr2nsPC7B5d6J1YNU4y
         CGENQAI/Zf0zBhTIsVUT2/jYcCvVhWK9aroiR774m25XtARcVbqLNl3FtuO4bqKKAW/A
         3SuuuKXKtraxXFGHzfCVgwB+GLMaw4ndFQZffxAKuSCFhMFDpcD86m7PzNkmsqzY9Rba
         MbBw==
X-Gm-Message-State: APjAAAX+D9Wd75nFMJ+fEcjjkDSu/cb7Z7LRKrjH12NcHlDwDhyQIgxv
        Yz85/YUZ1lNKsgIyCy3sSO09XA==
X-Google-Smtp-Source: APXvYqxV6rMy9dQYUsDUhw34dxJcbgiNialbhoKef1TA6WeIZ0TbVwcN/WMQhN5djmXnN4I0lQ9WEQ==
X-Received: by 2002:a17:902:24a2:: with SMTP id w31mr63133354pla.78.1555597698567;
        Thu, 18 Apr 2019 07:28:18 -0700 (PDT)
Received: from [10.99.178.44] (p3300202-ipngn21401hodogaya.kanagawa.ocn.ne.jp. [153.129.48.202])
        by smtp.gmail.com with ESMTPSA id r145sm6290213pgr.84.2019.04.18.07.28.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Apr 2019 07:28:17 -0700 (PDT)
Date:   Thu, 18 Apr 2019 23:28:10 +0900
User-Agent: K-9 Mail for Android
In-Reply-To: <20190417154900.GD7751@bombadil.infradead.org>
References: <20190417131531.9525-1-mcroce@redhat.com> <20190417154900.GD7751@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
Subject: Re: [PATCH v3] proc/sysctl: add shared variables for range check
To:     Matthew Wilcox <willy@infradead.org>
CC:     LKML <linux-kernel@vger.kernel.org>, linux-fsdevel@vger.kernel.org,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>
From:   Matteo Croce <mcroce@redhat.com>
Message-ID: <BD9BF74B-010D-47F1-9CF6-AA2742EFB779@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On April 18, 2019 12:49:00 AM GMT+09:00, Matthew Wilcox <willy@infradead.org> wrote:
> On Wed, Apr 17, 2019 at 03:15:31PM +0200, Matteo Croce wrote:
> > In the sysctl code the proc_dointvec_minmax() function is often used
> to
> > validate the user supplied value between an allowed range. This
> function
> > uses the extra1 and extra2 members from struct ctl_table as minimum
> and
> > maximum allowed value.
> > 
> > On sysctl handler declaration, in every source file there are some
> readonly
> > variables containing just an integer which address is assigned to
> the
> > extra1 and extra2 members, so the sysctl range is enforced.
> > 
> > The special values 0, 1 and INT_MAX are very often used as range
> boundary,
> > leading duplication of variables like zero=0, one=1, int_max=INT_MAX
> in
> > different source files:
> > 
> >     $ git grep -E '\.extra[12].*&(zero|one|int_max)\b' |wc -l
> >     245
> > 
> > This patch adds three const variables for the most commonly used
> values,
> > and use them instead of creating a local one for every object file.
> 
> Does this actually cause the kernel size to shrink?  EXPORT_SYMBOL
> isn't
> free, you know.

Hi Matthew,

In this case we have three __kstrtab_ symbols of size 11,12 and 15, and a bunch of u32 removed, so the size should shrink anyway.
I will try to calculate the exact saving with bloat-o-meter.

Regards,
-- 
Matteo Croce
per aspera ad upstream
