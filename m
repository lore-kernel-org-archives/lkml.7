Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90CC7C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 13:20:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 670D92464B
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 13:20:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dE92+E8K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729578AbfLKNUW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 08:20:22 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:52963 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728128AbfLKNUU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 08:20:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576070419;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=o/u/4ZEqQP0e+uS2+lCszxa5LZBpaQoPz1LVNN7voyg=;
        b=dE92+E8Keo6YqSkUKbQr++CMuiQIjplKbMtXwxLR0fWUD8bB7y+amC3EK6XdBZG3b2yX/K
        lp0cS0lQKTzj4978xYr3d/J15PIhdqDY8iDFyGL5vD2ZYDQDEFAgKHOIPeHZCagY9KIbYS
        SX6HWPIMMFf0vzb0yKQw2XPkUbdr/UM=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-141-drEHkx9cNC2qmQrIYoLj9A-1; Wed, 11 Dec 2019 08:20:15 -0500
Received: by mail-lf1-f70.google.com with SMTP id t8so2103303lfc.21
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2019 05:20:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=o/u/4ZEqQP0e+uS2+lCszxa5LZBpaQoPz1LVNN7voyg=;
        b=ZV+Mt98F3X/m7eXxwSm7vSbDcownO0Hr3Ced9hl+LT69z87V/TmX7ZyNq/6u2fq4WM
         xF204BdrefoZ91MJ13t1ZoMnA6JUl5LNsiVC+mV4lAz8I5yVYljOHFjgNQoO7XYrQNuZ
         +1FszZBNZuJbAzbsCktX4yGikwna0/+CfsgyKrx05DoMS27K0MqFsQkO8EYoepejlgdt
         me1UrAL8JRr4gcgjwDCR0wizrTXvJj+eYWKN4uHo7EnStozCma7Z96t5j3O+8DkX/YTz
         cP5wUC2ngb7xr4Z6WeCyxbdvzw5DFXGlJa7R/tqDxyawLxeTmI4DbtJgE/zwVHPAPFR7
         2Wrw==
X-Gm-Message-State: APjAAAUxB62havg1GRoC44tzfVU1jH5zuaYfvyoj60zZbeA5iECFUPan
        q/wFfBQvzkEGpD1E9Rvm3KLMEVPEfjAsXyCREvvu8CHCcGAMoXmH8oEsWgEpe7gBffr4GZ3zRwm
        3Iy1Mk71cm+3c/1c1jGYMTKi5
X-Received: by 2002:a2e:9b95:: with SMTP id z21mr1806008lji.112.1576070414501;
        Wed, 11 Dec 2019 05:20:14 -0800 (PST)
X-Google-Smtp-Source: APXvYqxiBoj4+UzNM6MVzGlRn15zbpyF65rItNLpqEE+jZ6WQC2/2JVmPf9if2K7dMUlgg9zx4M+KA==
X-Received: by 2002:a2e:9b95:: with SMTP id z21mr1805990lji.112.1576070414253;
        Wed, 11 Dec 2019 05:20:14 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id c12sm1157656lfp.58.2019.12.11.05.20.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2019 05:20:13 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 64AA318033F; Wed, 11 Dec 2019 14:20:11 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     Jakub Kicinski <jakub.kicinski@netronome.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        lkml <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org,
        bpf@vger.kernel.org, Martin Lau <kafai@fb.com>
Subject: Re: [PATCH bpf v2] bpftool: Don't crash on missing jited insns or ksyms
In-Reply-To: <20191211130857.GB23383@linux.fritz.box>
References: <20191210181412.151226-1-toke@redhat.com> <20191210125457.13f7821a@cakuba.netronome.com> <87eexbhopo.fsf@toke.dk> <20191211130857.GB23383@linux.fritz.box>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Wed, 11 Dec 2019 14:20:11 +0100
Message-ID: <87zhfzf184.fsf@toke.dk>
MIME-Version: 1.0
X-MC-Unique: drEHkx9cNC2qmQrIYoLj9A-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Borkmann <daniel@iogearbox.net> writes:

> On Tue, Dec 10, 2019 at 10:09:55PM +0100, Toke H=C3=B8iland-J=C3=B8rgense=
n wrote:
> [...]
>> Anyhow, I don't suppose it'll hurt to have the Fixes: tag(s) in there;
>> does Patchwork pick these up (or can you guys do that when you apply
>> this?), or should I resend?
>
> Fixes tags should /always/ be present if possible, since they help to pro=
vide
> more context even if the buggy commit was in bpf-next, for example.

ACK, will do. Thank you for picking them up for this patch (did you do
that manually, or is this part of your scripts?)

-Toke

