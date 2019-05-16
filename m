Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21C89C04AAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 14:14:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E62BA20862
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 14:14:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lucidpixels.com header.i=@lucidpixels.com header.b="iJuq0PfZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727671AbfEPOOY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 10:14:24 -0400
Received: from mail-ot1-f44.google.com ([209.85.210.44]:45432 "EHLO
        mail-ot1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726758AbfEPOOX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 10:14:23 -0400
Received: by mail-ot1-f44.google.com with SMTP id t24so3511736otl.12
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2019 07:14:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lucidpixels.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RsaSaG1NFGpYRcNeKVnQAUdFFVrTcssH0eQR8vzaBKY=;
        b=iJuq0PfZMogW29T51LM6g/eeSMyMgmP41bX0IaGccKhwnxgYFpgkmRu41bxDJ+jGEc
         O2dM+dmUVN2zBTdOwcSR6hsv1CNvAj56KNRkHfFObLjri2ampeo2BXoWY+tU5Bnu8jzV
         qZg9ll0q9y+co9lywwWmJgktOd8UW8iWY59zg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RsaSaG1NFGpYRcNeKVnQAUdFFVrTcssH0eQR8vzaBKY=;
        b=e4nY+8ABGwuXScUUdI4wl3JEFVNaHXW927cLwxvADNbAPehMOd4Cz9sNJw9Y+/X28e
         gdJLPJzvnZwLizuiulkOT11Nc1REH77e5zXTOsQCXO4tzwpwjk7pS9OHnZrlL97ZwRwZ
         wIh+xVIh/cTcTRX5Lb6v9MB+5TeT70Y7B0i3fXkyq4nDsvcj6mX87eQyHHXEsv/J7iJs
         PrtRv6mbAvDrxnQ3aEiXNIoNRYhG4poVWpf38f6gKbP9yhOd32jblM51RBKjw4msvAYu
         eLIBn6BL+eDVDj/+F92YIm5GXPvoH2tloD/pqhQKtfd2c2o611sLNtsUDelGOs9yVbdM
         0/9Q==
X-Gm-Message-State: APjAAAW6Q3eXQKoprEzjWV+vomM2qnAKfwJwrEmMOsLLelLwY/2C8Db7
        F1JhBMgZXDEoaVtIZ5fDTdyvxkT7B5EqcRWPBTBygVL94REPAA==
X-Google-Smtp-Source: APXvYqwD+/gZECI3zFgzjJAgP2TiIxG8glh5mnS2EnBAXxoiCM41cAtoQYD6AsG6YGO1VPfovo4+t4Jav1VF4wyfYUc=
X-Received: by 2002:a9d:400d:: with SMTP id m13mr9918150ote.100.1558016062305;
 Thu, 16 May 2019 07:14:22 -0700 (PDT)
MIME-Version: 1.0
References: <002901d5064d$42355ea0$c6a01be0$@lucidpixels.com> <20190509111343.rvmy5noqlf4os3zk@box>
In-Reply-To: <20190509111343.rvmy5noqlf4os3zk@box>
From:   Justin Piszcz <jpiszcz@lucidpixels.com>
Date:   Thu, 16 May 2019 10:14:10 -0400
Message-ID: <CAO9zADww2v2ckHsNDwRgiyMr9b3JH1xOOSiRJ0Uh2XZT5c=MEQ@mail.gmail.com>
Subject: Re: 5.1 kernel: khugepaged stuck at 100%
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 14, 2019 at 9:16 AM Kirill A. Shutemov <kirill@shutemov.name> wrote:

> Could you check what khugepaged doing?
>
> cat /proc/$(pidof khugepaged)/stack

It is doing it again, 10:12am - 2019-05-16

  PID USER      PR  NI    VIRT    RES    SHR S  %CPU  %MEM     TIME+ COMMAND
   77 root      39  19       0      0      0 R 100.0   0.0  92:06.94 khugepaged

Kernel: 5.1.2

$ sudo cat /proc/$(pidof khugepaged)/stack
[<0>] 0xffffffffffffffff

$ perf top

   PerfTop:    3716 irqs/sec  kernel:92.9%  exact: 99.1% lost: 68/68
drop: 0/0 [4000Hz cycles],  (all, 12 CPUs)
-------------------------------------------------------------------------------

    47.53%  [kernel]                 [k] compaction_alloc
    38.88%  [kernel]                 [k] __pageblock_pfn_to_page
     6.68%  [kernel]                 [k] nmi
     0.58%  [kernel]                 [k] __list_del_entry_valid
     0.48%  [kernel]                 [k] format_decode
     0.39%  [kernel]                 [k] __rb_insert_augmented
     0.25%  libdbus-1.so.3.19.9      [.] _dbus_string_hex_decode
     0.24%  [kernel]                 [k] entry_SYSCALL_64_after_hwframe
     0.20%  perf                     [.] rb_next
     0.19%  perf                     [.] __symbols__insert
