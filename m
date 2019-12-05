Return-Path: <SRS0=yQuH=Z3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0AA2C43603
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 19:55:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8460E20707
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 19:55:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g4ZtROh3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729685AbfLETy7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Dec 2019 14:54:59 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:58037 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729145AbfLETy7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 14:54:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575575698;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bV8SWjNXtxP1IwqvIWSeZiIB97GtM4TrtLpqcXfhVJg=;
        b=g4ZtROh3KCtLtolSYtaR8pshQh0dOxyMV6sqBVzL2/uOtmLAYe2oAgBgt8Bez0yuuksqGy
        +8ZfyjGn9jvkP2Ja5idoumQcPxza2HPu3bgZ82izgxET6d6HJaouV0zkq/O1qfuyuUxz9P
        dC2RE7Z7/GeDpLXPpdPTYxmXjj4ajQ4=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-352-Etib965FMKW6QF1owjocwQ-1; Thu, 05 Dec 2019 14:54:54 -0500
Received: by mail-oi1-f198.google.com with SMTP id e22so2322180oig.1
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2019 11:54:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bV8SWjNXtxP1IwqvIWSeZiIB97GtM4TrtLpqcXfhVJg=;
        b=a9uWO1UhaIE+hoCKwLdYaq+LBXYdKP5O4hR4F8AcgPyfpboZ/+U4/lDokv5+5t/cgS
         RzPREAhepVchbg+vxEPQnb65lpbRP5AyOyyXYP0ee2QRa8Cq+Q1lrEQuvjtbWSYiue3+
         4ZuaZ1vUJfOBl7Qr592dSHg/YWNiWY9smLYhcSAYVxdej4uGF8d8zQ/RvkojQRYwMDH4
         fH4CveKflhpIM2En1pri3O63BeLKeuG5N32o/qUEQv28ZiluXToMcUllm9/RZuhOummH
         IOna+NYk3apbgo6Lfe8gd/vdYzUx/yJJYskUcPq6k03rxBYX+dsbTfDVzIsgepovoDYO
         0nfA==
X-Gm-Message-State: APjAAAUF2TNt7bQbz4CPGRuVGmRNDXWReWZhUPfhdu74xlCkewyGwA8r
        CzAgY0cjXvc0dYD3rvEoIFphFKZU1LpmDzz9QxNCXeurVWfsSC7g15cr5uT/HnZNb5iwI135IVg
        AWZYwjFSm0qHLx0BYJUTJrxHDl7N/cKG5kU4uk7bm
X-Received: by 2002:a54:4817:: with SMTP id j23mr3134336oij.152.1575575694102;
        Thu, 05 Dec 2019 11:54:54 -0800 (PST)
X-Google-Smtp-Source: APXvYqzOzQYeNXdptc6UzHvcsEGhlDRD2E6q9r2/6ID9yEOc8jYP3umcpWhaNl+JgiiamB6NrEbAhucmvBqn3sXc8tk=
X-Received: by 2002:a54:4817:: with SMTP id j23mr3134331oij.152.1575575693936;
 Thu, 05 Dec 2019 11:54:53 -0800 (PST)
MIME-Version: 1.0
References: <1574324085-4338-1-git-send-email-clabbe@baylibre.com>
 <20191202133254.GA21550@Red> <CAMwc25obOebugXGSNVWd1bjPN+tR82wwFJ6PgqnvZXK4O6xAFw@mail.gmail.com>
 <20191205152945.GB10549@Red>
In-Reply-To: <20191205152945.GB10549@Red>
From:   David Airlie <airlied@redhat.com>
Date:   Fri, 6 Dec 2019 05:54:42 +1000
Message-ID: <CAMwc25pgOx+_2NaJb4vb4bf_mvKD8QYfQAbP7TV2tRUa2yWjrw@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] agp: minor fixes, does the maintainer still there ?
To:     LABBE Corentin <clabbe@baylibre.com>
Cc:     airlied <airlied@linux.ie>, arnd@arndb.de, fenghua.yu@intel.com,
        "KH, Greg" <gregkh@linuxfoundation.org>,
        "Luck, Tony" <tony.luck@intel.com>, linux-ia64@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
X-MC-Unique: Etib965FMKW6QF1owjocwQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Thanks for applying.
> Perhaps you need to fix your address in MAINTAINERS.
>
> When you has hardware, What was your tests procedure ?
Just boot and run gears type thing.

> I can on my freetime add some AGP hw on my kernelCI lab.
>

I don't know where to get AGP hw these days that isn't horrible power
consumption wise, I can't really wish for anyone to ever put it into
CI for an area that we change once a year.

I'd rather we just don't touch AGP too much and let it die and remove
support in 5-10 years.

Dave.

