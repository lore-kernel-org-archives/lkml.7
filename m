Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0FBEC31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:25:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71AA42082C
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:25:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="V1kObx8W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732154AbfFMPY7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 11:24:59 -0400
Received: from mail-io1-f41.google.com ([209.85.166.41]:42104 "EHLO
        mail-io1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731674AbfFMMMF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 08:12:05 -0400
Received: by mail-io1-f41.google.com with SMTP id u19so16279297ior.9
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2019 05:12:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6TnqYw+JH0yXL0cYBb0DT/5cCjybbJ0FkJFzKrPy/Ks=;
        b=V1kObx8WFKLXYMLDacaZYfPCx7cuX/IA1LFq0ZQgLWAhg1D+voGEfUagJ645qIod/k
         zGsXPiqk/Lqd34ObQupyesy1ZWwYRn4JJgZYrUNAhinntdvRuvv/WKGNUQ1CzGo77vZI
         HP27MV24tXmnPjITSM4yW0sUzQZ0bjDFAppf0fVDVLoyoOZEhMRz+m/JrdY2DmbhjqaB
         /fj1ntsBGZHDRJj9F2KyBisjtbnbm1G19+nfPG0p3m1qvVVNLMemEyuCeVdMA0IngggG
         vBjhGKmCmQKU4bEJ3/jtx+XCZqrxXvoxyG9f3sF4nQUxGgJ+AV93Oh/GUr/cB65beXrU
         IHag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6TnqYw+JH0yXL0cYBb0DT/5cCjybbJ0FkJFzKrPy/Ks=;
        b=m3zPlB9w46EhFWghlSuMqCsnaWLzpvmhbKG4tHHYRcQAsn7RdBs9r58XCyXAeHVetp
         8M7/wgqsnw+dJ0jrG+olSAUxhWBeBH8MAOm7u3RK2oS3Uu6QVnp1ec8pDTUxat8voZo/
         6K2c2vt03UoTdswGY1Q5R8rZqyRnPhbnQgiDFWCWWMi44K8b5WTyLgQtYD8yjXNigX+i
         uix2Fx+jbavkwFRfC7obaUyf3Zy2Tkhk+JeZajnWzm7IuW6OVCr7pB7F6bzPHItFnCXW
         wfAuCTZW2OpSCNMvJqM1c0eoGudmC05rgEPiKBRjWyS4bpusRVpY3frvv+ZmIvRHJoEM
         CsPw==
X-Gm-Message-State: APjAAAXN4M3xRhZzaOgivyD4xDv0HhGjgf+MIvOWzoYDr+dIMhJ40lFx
        sndjuoVwDn9TcqBqVcVYk0AlRvxQxsVfsF2O0Qr0dQ==
X-Google-Smtp-Source: APXvYqyCTIGH2L4bZDuCnup/5Krt+juZXVarS330yujDiKA6yKNS0mtgMz1H4aP3TlXSLRHvxmG6k/hJzd4683l6yRQ=
X-Received: by 2002:a6b:fb0f:: with SMTP id h15mr3118490iog.266.1560427923857;
 Thu, 13 Jun 2019 05:12:03 -0700 (PDT)
MIME-Version: 1.0
References: <20190613120659.10680-1-hdanton@sina.com>
In-Reply-To: <20190613120659.10680-1-hdanton@sina.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 13 Jun 2019 14:11:52 +0200
Message-ID: <CACT4Y+ZaoM4c739MM5KXH7K0_oeRsQ8F4Erptv8bjbx0JFuS-w@mail.gmail.com>
Subject: Re: memory leak in vhost_net_ioctl
To:     Hillf Danton <hdanton@sina.com>
Cc:     Jason Wang <jasowang@redhat.com>,
        syzbot <syzbot+0789f0c7e45efd7bb643@syzkaller.appspotmail.com>,
        "ast@kernel.org" <ast@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "hawk@kernel.org" <hawk@kernel.org>,
        "jakub.kicinski@netronome.com" <jakub.kicinski@netronome.com>,
        "john.fastabend@gmail.com" <john.fastabend@gmail.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mst@redhat.com" <mst@redhat.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "syzkaller-bugs@googlegroups.com" <syzkaller-bugs@googlegroups.com>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "xdp-newbies@vger.kernel.org" <xdp-newbies@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 13, 2019 at 2:07 PM Hillf Danton <hdanton@sina.com> wrote:
>
>
> Hello Jason
>
> On Thu, 13 Jun 2019 17:10:39 +0800 Jason Wang wrote:
> >
> > This is basically a kfree(ubuf) after the second vhost_net_flush() in
> > vhost_net_release().
> >
> Fairly good catch.
>
> > Could you please post a formal patch?
> >
> I'd like very much to do that; but I wont, I am afraid, until I collect a
> Tested-by because of reproducer without a cutting edge.

You can easily collect Tested-by from syzbot for any bug with a reproducer ;)
https://github.com/google/syzkaller/blob/master/docs/syzbot.md#testing-patches
