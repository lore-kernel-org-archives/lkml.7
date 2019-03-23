Return-Path: <SRS0=q9dy=R2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2CB8C10F05
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 15:03:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 786082192B
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 15:03:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KOXf7RbT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727621AbfCWPA6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Mar 2019 11:00:58 -0400
Received: from mail-lf1-f53.google.com ([209.85.167.53]:46904 "EHLO
        mail-lf1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726649AbfCWPA6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Mar 2019 11:00:58 -0400
Received: by mail-lf1-f53.google.com with SMTP id r25so3240589lfn.13
        for <linux-kernel@vger.kernel.org>; Sat, 23 Mar 2019 08:00:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/RTRTgGO3ujc1ETR+qlPzJK8tswzkOkXw298p+7vh5U=;
        b=KOXf7RbT5fdYHCoya6f2n2XUmuouRpLVVLrjglwWTDzUAAx67ajlyfrVolA7MCEUtw
         2Ea+TVl/LYv+/6TioXwybSxAUmw5rQ1un4yquL0za1b1Zg9aOJ9p+xStYAEyEFStl8Cw
         vPk1m2fg+AiQXJ50xMqbdopdPLdcsM7dF/BFmWSG2ZNPTCzbbPOhVK3LMvkFjg3qxMuO
         croPpetQVGqo99PytDElDMa758IoAeJ3I5003uaMTq8RwOnGrZ81k8lQHYgUXs8hm5lq
         FsorNKGEl6WeLifqFSjKSodV15kkW+4O3dD4NU9PoPtn8EjDSyAOeEIe2doBhsOthdF8
         /tUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/RTRTgGO3ujc1ETR+qlPzJK8tswzkOkXw298p+7vh5U=;
        b=ZFRrIMxyMRyRVgueVm+cZYBkPIWiuBjs9ntWCXuXxIN30zduKnEd7Yzgs/ygCjl2Ps
         VyGTo+cLhUj0bvXsckJKExmKZxg3Y31OkBDzddcwlcS++O8Ml54fetGB4orvThdA5gxe
         P+aXVWhBPFlIxAZ6GVnmfMNPqr4VRlBnGQjQNqP2beYqxAjNydWzHPXz7/436IfXPw+o
         2gPRY4nHHeqauZurKKBomp0Vaulcjg3gnammal+KHDkKLYjweryFCCjZXL9/tP+HuAjl
         P/sMBLPr7JVlk9vDl+bHxtF1Xub0swA+ain7e4dgdOh6tIHdNK/zEkNhvli8JxZsgl/s
         l54A==
X-Gm-Message-State: APjAAAWoN7MKiIod0/k94POoUSaYVXXjR9F720qfsQabNHt+08JON+Pq
        3aWWR9CnbKNkLDBG/ubOc1gmb6PBmyDc/yUqDlMRjw==
X-Google-Smtp-Source: APXvYqxUMMQmtsJwRghSFIasrPMVQNUYbTMxR/E7YbqjbiBmTNbtLtEvQHbJMhP7NFy7+4jmfoPOMnJsNHorpKLOQNI=
X-Received: by 2002:ac2:495c:: with SMTP id o28mr3494159lfi.16.1553353256487;
 Sat, 23 Mar 2019 08:00:56 -0700 (PDT)
MIME-Version: 1.0
References: <20190301184816.784-1-mans@mansr.com> <CANiq72=H1Gubbr+eoEKUR+m49fkcC7Sr_hsyP3azzpk=i-au+Q@mail.gmail.com>
 <CANiq72=fExsa6cxG=TpuQb3OxcFDdfQhfrE5=OU8vS0gn8KgZA@mail.gmail.com> <c6800354-bd44-59b6-df03-3f2448e354a8@infradead.org>
In-Reply-To: <c6800354-bd44-59b6-df03-3f2448e354a8@infradead.org>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Sat, 23 Mar 2019 16:00:45 +0100
Message-ID: <CANiq72ka10gaVq9pTc-Z5k6xJzLTyj-VpHi8vH03=1z7Fi_yMg@mail.gmail.com>
Subject: Re: [PATCH 1/3] auxdisplay: deconfuse configuration
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Mans Rullgard <mans@mansr.com>,
        Ksenija Stanojevic <ksenija.stanojevic@gmail.com>,
        Willy Tarreau <w@1wt.eu>,
        Geert Uytterhoeven <geert.uytterhoeven@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 23, 2019 at 3:51 PM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> I haven't seen any issues with this in linux-next, so go ahead, please.

Thanks for the very quick answer, Randy!

Cheers,
Miguel
