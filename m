Return-Path: <SRS0=HJxx=ZB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 074C9C43331
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Nov 2019 19:15:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C448E21924
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Nov 2019 19:15:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ePSt1190"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726617AbfKITPJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Nov 2019 14:15:09 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:39283 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726240AbfKITPJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Nov 2019 14:15:09 -0500
Received: by mail-io1-f66.google.com with SMTP id k1so9950963ioj.6
        for <linux-kernel@vger.kernel.org>; Sat, 09 Nov 2019 11:15:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=m3uHaDtX3ciBcivMZkabAXv4IXjFfi/2JONmJEnyS4M=;
        b=ePSt1190uSUtkKVT7AcYJCK/9mEFMs2fcnIW8CXipRh0Uij1ERuPFcP9Z6j9nP5cU8
         cvg2JYrUz4Xcqtrsww7BZF/V2cjGm/BLtaIrEmKEpZR9aVfCKcO+gzRCRrVVYwt016kb
         qLsdwn/GRSBYt/RdX+3oYIcogVflgtIY2kc91OLxYxmGkZ02HcC89qDnKV67k4iEFrnL
         8aAt+cNdByueRGyFY352k39BXp7zKk+L04/tovhdXTys3yJtPnCN/+zWyMpwxWL+1vB0
         K2c5EWoFN60Wf82GL09DMjKF/3Bzbmc10de1Qnd71x4aRYs44K+jgYRV+pucF5rL71wl
         zI4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=m3uHaDtX3ciBcivMZkabAXv4IXjFfi/2JONmJEnyS4M=;
        b=TcxrfToTjp4zR/pat2gLkpNYnqcvNwBSBliTU0X2jVjACTbvh0eH53x/2njAU/vSfk
         R3o8YunnvsIud08GyD4S0iNkUqpueOxkVBmCYIdy4qKmHYBJ5sv+1k/Q4MTpx0zPkJuk
         m+KYN+ZCYv46q6Q47B7wBd/qlR6oFjCSZjPeXwu6GZThSTL3DEyE8xQ+eb+ZJ+62W+aL
         EtiyHfWPwCDVDtzrn3RnMn1hrjd8zQsesLe5TmBPgr9g+s4JkEY2lNF+AaoWtWOJEMsP
         E5ijt6ULL7AgzCQbEPCmfcezgrM93jcPRq0YNUf0db03ognMcRVCa2KSYdvQOtYLgLG7
         l8rQ==
X-Gm-Message-State: APjAAAUJFsgwg9TK97gCMes12l+cROAt61t1OhlFEZkqMBOOnCsyLIly
        5ZfAni7qpcMxRfFg9Id+HXvrxZGOI6EDussOnqUYcuX/
X-Google-Smtp-Source: APXvYqxd+hQmm9NUBZZ92s9ppGwgDcdK/45ch/+C4eAFe7jDNBMIQAdLxIKoTqgiZG/fGxBCEXV/750J3JvRnlEt+Ls=
X-Received: by 2002:a02:3f10:: with SMTP id d16mr17771812jaa.139.1573326906644;
 Sat, 09 Nov 2019 11:15:06 -0800 (PST)
MIME-Version: 1.0
References: <20191108213257.3097633-1-arnd@arndb.de> <20191108213257.3097633-5-arnd@arndb.de>
In-Reply-To: <20191108213257.3097633-5-arnd@arndb.de>
From:   Deepa Dinamani <deepa.kernel@gmail.com>
Date:   Sat, 9 Nov 2019 11:14:55 -0800
Message-ID: <CABeXuvoBUf59O3s-xRJa0t8qb5HJxWi0E5765dUjchymq47eig@mail.gmail.com>
Subject: Re: [PATCH 04/16] dlm: use SO_SNDTIMEO_NEW instead of SO_SNDTIMEO_OLD
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     y2038 Mailman List <y2038@lists.linaro.org>,
        Christine Caulfield <ccaulfie@redhat.com>,
        David Teigland <teigland@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Richard Fontana <rfontana@redhat.com>,
        Alexios Zavras <alexios.zavras@intel.com>,
        Willem de Bruijn <willemb@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        David Windsor <dwindsor@redhat.com>,
        cluster-devel <cluster-devel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Acked-by: Deepa Dinamani <deepa.kernel@gmail.com>
