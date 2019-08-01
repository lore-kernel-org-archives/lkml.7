Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5A92C19759
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 23:16:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C77D2080C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 23:16:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="F/+sle/f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732830AbfHAXP7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 19:15:59 -0400
Received: from mail-yb1-f196.google.com ([209.85.219.196]:42656 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728834AbfHAXP7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 19:15:59 -0400
Received: by mail-yb1-f196.google.com with SMTP id f195so26272083ybg.9
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2019 16:15:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=06Xjl8xwVElD8TuadDbhO8wIkDa5jiIzMLYGbCJ3IQM=;
        b=F/+sle/fJAUc8KeIW+463HFv2iEswCUDe0Le+Vpa4TxfuKdzpeleEYMIfoeb0K8rIc
         7QXiBPPdWrJhKSTjcGREsRP60wmlUSpbHtC+/mLrsiJo9NbNtQYQmU2HJidAoxJ5K/R5
         mKTHFeWOdm/MkCRoKVwdVQahn/1ZtB17tOhEQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=06Xjl8xwVElD8TuadDbhO8wIkDa5jiIzMLYGbCJ3IQM=;
        b=hChdiZoDm7LCSLmbj30KdmvmJGZkhIGJPkPelGseIhdUynoerUmbTNmZSS+JpvHpi0
         Vc795RzkhYmxzYJ4OqOPiKrygPAOuvitjTD8bCgwDeJX7BdJXo5cdJr/WstoPPC9lyMp
         lHQdbbQY8SMLr6yMeouMyxUK6kIHeisU1MAstk/SaxdvRo3YpRF2DrH4UgjVV+S5WNyV
         nCQmWRPSm8+1stnjypDCtAuHK07a//gzUfaUYXIbFwUxncUBqRA/IzqIoDQCHVwpaBtJ
         5k5fd43EqenzTxcOSnqmo1Pbdybr1S8RJDa1IPX3M7bkAHvE5KMWOOcJVOP6/l4ihVoa
         qDug==
X-Gm-Message-State: APjAAAWDbDYLRBW605/LY3qFjzpqWeiB3rOoF5t+DNiQrRIJmtqwIk+0
        XKQQJGbbWc0TU6+7haX7O2bpgnB21TIdmVKqf6NOnA==
X-Google-Smtp-Source: APXvYqymJLYJBEWw5p4DhtooQ8mDGh029PXr4gbweTcKgJnidReKSoTRPoK/0zMnFXIx/KJZcYFVG1r+s1cW2/q9/UA=
X-Received: by 2002:a25:85:: with SMTP id 127mr84946065yba.186.1564701358458;
 Thu, 01 Aug 2019 16:15:58 -0700 (PDT)
MIME-Version: 1.0
References: <20190731122224.1003-1-hslester96@gmail.com> <CACKFLinuFebDgJN=BgK5e-bNaFqNpk61teva0=2xMH6R_iT39g@mail.gmail.com>
 <CANhBUQ1J8hXBZv4x3pJhG_08ZS1zR=9Uj2EUta2sgtyND_QKPw@mail.gmail.com>
In-Reply-To: <CANhBUQ1J8hXBZv4x3pJhG_08ZS1zR=9Uj2EUta2sgtyND_QKPw@mail.gmail.com>
From:   Michael Chan <michael.chan@broadcom.com>
Date:   Thu, 1 Aug 2019 16:15:47 -0700
Message-ID: <CACKFLi=r11QYhMbO56EDY4mNOB_x3jkR-_zWh8hg_-GL-=t0rg@mail.gmail.com>
Subject: Re: [PATCH 2/2] cnic: Use refcount_t for refcount
To:     Chuhong Yuan <hslester96@gmail.com>
Cc:     "David S . Miller" <davem@davemloft.net>,
        Netdev <netdev@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 31, 2019 at 7:22 PM Chuhong Yuan <hslester96@gmail.com> wrote:
>
> Michael Chan <michael.chan@broadcom.com> =E4=BA=8E2019=E5=B9=B48=E6=9C=88=
1=E6=97=A5=E5=91=A8=E5=9B=9B =E4=B8=8A=E5=8D=881:58=E5=86=99=E9=81=93=EF=BC=
=9A
> >
> > On Wed, Jul 31, 2019 at 5:22 AM Chuhong Yuan <hslester96@gmail.com> wro=
te:
> >
> > >  static void cnic_ctx_wr(struct cnic_dev *dev, u32 cid_addr, u32 off,=
 u32 val)
> > > @@ -494,7 +494,7 @@ int cnic_register_driver(int ulp_type, struct cni=
c_ulp_ops *ulp_ops)
> > >         }
> > >         read_unlock(&cnic_dev_lock);
> > >
> > > -       atomic_set(&ulp_ops->ref_count, 0);
> > > +       refcount_set(&ulp_ops->ref_count, 0);
> > >         rcu_assign_pointer(cnic_ulp_tbl[ulp_type], ulp_ops);
> > >         mutex_unlock(&cnic_lock);
> > >
> >
> > Willem's comment applies here too.  The driver needs to be modified to
> > count from 1 to use refcount_t.
> >
> > Thanks.
>
> I have revised this problem but find the other two refcounts -
> cnic_dev::ref_count
> and cnic_sock::ref_count have no set.
> I am not sure where to initialize them to 1.
>
> Besides, should ulp_ops->ref_count be set to 0 when unregistered?

I will send a patch to fix up the initialization of all the atomic ref
counts.  After that, you can add your patch to convert to refcount_t.
