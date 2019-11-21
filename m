Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE3FFC432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 10:17:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FDB6206CB
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 10:17:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WMnWzBkW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726573AbfKUKRw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 05:17:52 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:39247 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726230AbfKUKRw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 05:17:52 -0500
Received: by mail-lj1-f193.google.com with SMTP id p18so2564648ljc.6
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2019 02:17:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Rheqpv+csTnpb1w5YOY3zSExeiGEQ+raK4EDVtBWW4w=;
        b=WMnWzBkWpblOJXHtBpgKuaSg1YvLuhyexdSnT7EzahFtMeotDLWmNPrHV22uS2Xnt0
         XWXvOqSxcySWzPWHPUKRN3PXUHe5ieefgqvfqQl785FRfOylPoynYMlZPAyRafkBz4CI
         s/MJ41KHecozDEBLtZSGbZKkes+TBMJkXul/p2zkCYlAXcVjb2uKoV3zYMM7mqe9WxC/
         XcOdVdmo/Zyv4xZ8l46yF1jJ5rujWc/oksgceMuZOviyEz4LD4nUzaW4VLD+mFhVuGpe
         tBx0bTbxB1d2ILUaDw4JVtQDebmpySLCa0rd0Lx9aQQT53BG+Ss7JV5kSiOjSFeAEXDK
         iCgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Rheqpv+csTnpb1w5YOY3zSExeiGEQ+raK4EDVtBWW4w=;
        b=h1qMNgY+wisVFbRPKfC39HoajG2n90J4siby2BIMti4wFqtJ9+wXKvigRBNgxUXKS/
         94JCDUTNa28vJga8MODWwC4JrE16IfQgrCFXVLMYyoNGE+f9u3V+4dmlY9qErqgJ59kL
         8veypmyuAaEHZEYl7FU3WUOiKeh6neLq4P/cLt+WwW3lsDdmL7rQgyoEo+aIFIzivRF9
         durA4vIjqeHBJdF19eoIR9DlXbnld1rHe7SYFsJSo6GOEmUjoSn1Sf+JZv7ZKAhpv9Dl
         ABNT/Mn62glznwvLtfIHbDIKK10wuXOaEo1+I9gLy4xrVZSgLIFBrlEmPwJqulQR1NHU
         d4/Q==
X-Gm-Message-State: APjAAAXgps0qygINvF2NIKSViZsfV9n4ckXzubvcB2IV3vYq29b5jwyY
        0HSI1x24Zg+LLfcKe3w97MrBPlCUZlB1tIyy0/URMg==
X-Google-Smtp-Source: APXvYqzoPhxuoILpiM9Yoh4zgQ3kQEN+dWeTvGtJqk2XIWxJ/hY26LGyWTPuIJAWlt7jegKJCexwd25YDrog3m6wtW4=
X-Received: by 2002:a2e:b163:: with SMTP id a3mr6535836ljm.72.1574331468835;
 Thu, 21 Nov 2019 02:17:48 -0800 (PST)
MIME-Version: 1.0
References: <20191120152255.18928-1-anders.roxell@linaro.org>
 <e07311c7-24b8-8c48-d6f2-a7c93976613c@gmail.com> <CADYN=9Jzxgun9k8v9oQT47ZUFGPhCnsDoYaohG-DXmA1De1zXg@mail.gmail.com>
In-Reply-To: <CADYN=9Jzxgun9k8v9oQT47ZUFGPhCnsDoYaohG-DXmA1De1zXg@mail.gmail.com>
From:   Anders Roxell <anders.roxell@linaro.org>
Date:   Thu, 21 Nov 2019 11:17:37 +0100
Message-ID: <CADYN=9Kzz0DoK+hMaWqUyxXYrpTXpxG6YEWz-fo1Zgt+Z37T3Q@mail.gmail.com>
Subject: Re: [PATCH v2] net: ipmr: fix suspicious RCU warning
To:     Eric Dumazet <eric.dumazet@gmail.com>
Cc:     David Miller <davem@davemloft.net>, kuznet@ms2.inr.ac.ru,
        yoshfuji@linux-ipv6.org, paulmck@kernel.org,
        Networking <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Nov 2019 at 08:15, Anders Roxell <anders.roxell@linaro.org> wrote:
>
> On Wed, 20 Nov 2019 at 18:45, Eric Dumazet <eric.dumazet@gmail.com> wrote:
> >
> >
> >
> > On 11/20/19 7:22 AM, Anders Roxell wrote:

[snippet]

> > > +     rtnl_lock();
> > >       err = ipmr_rules_init(net);
> > > +     rtnl_unlock();
> > >       if (err < 0)
> > >               goto ipmr_rules_fail;
> >
> > Hmmm... this might have performance impact for creation of a new netns
> >
> > Since the 'struct net' is not yet fully initialized (thus published/visible),
> > should we really have to grab RTNL (again) only to silence a warning ?
> >
> > What about the following alternative ?
>
> I tried what you suggested, unfortunately, I still got the warning.

I was wrong, so if I also add "lockdep_rtnl_is_held()" to the
"ipmr_for_each_table()" macro it works.

>
>
> [   43.253850][    T1] =============================
> [   43.255473][    T1] WARNING: suspicious RCU usage
> [   43.259068][    T1]
> 5.4.0-rc8-next-20191120-00003-g3aa7c2a8649e-dirty #6 Not tainted
> [   43.263078][    T1] -----------------------------
> [   43.265134][    T1] net/ipv4/ipmr.c:1759 RCU-list traversed in
> non-reader section!!
> [   43.267587][    T1]
> [   43.267587][    T1] other info that might help us debug this:
> [   43.267587][    T1]
> [   43.271129][    T1]
> [   43.271129][    T1] rcu_scheduler_active = 2, debug_locks = 1
> [   43.274021][    T1] 2 locks held by swapper/0/1:
> [   43.275532][    T1]  #0: ffff000065abeaa0 (&dev->mutex){....}, at:
> __device_driver_lock+0xa0/0xb0
> [   43.278930][    T1]  #1: ffffa000153017f0 (rtnl_mutex){+.+.}, at:
> rtnl_lock+0x1c/0x28
> [   43.282023][    T1]
> [   43.282023][    T1] stack backtrace:
> [   43.283921][    T1] CPU: 0 PID: 1 Comm: swapper/0 Not tainted
> 5.4.0-rc8-next-20191120-00003-g3aa7c2a8649e-dirty #6
> [   43.287152][    T1] Hardware name: linux,dummy-virt (DT)
> [   43.288920][    T1] Call trace:
> [   43.290057][    T1]  dump_backtrace+0x0/0x2d0
> [   43.291535][    T1]  show_stack+0x20/0x30
> [   43.292967][    T1]  dump_stack+0x204/0x2ac
> [   43.294423][    T1]  lockdep_rcu_suspicious+0xf4/0x108
> [   43.296163][    T1]  ipmr_device_event+0x100/0x1e8
> [   43.297812][    T1]  notifier_call_chain+0x100/0x1a8
> [   43.299486][    T1]  raw_notifier_call_chain+0x38/0x48
> [   43.301248][    T1]  call_netdevice_notifiers_info+0x128/0x148
> [   43.303158][    T1]  rollback_registered_many+0x684/0xb48
> [   43.304963][    T1]  rollback_registered+0xd8/0x150
> [   43.306595][    T1]  unregister_netdevice_queue+0x194/0x1b8
> [   43.308406][    T1]  unregister_netdev+0x24/0x38
> [   43.310012][    T1]  virtnet_remove+0x44/0x78
> [   43.311519][    T1]  virtio_dev_remove+0x5c/0xc0
> [   43.313114][    T1]  really_probe+0x508/0x920
> [   43.314635][    T1]  driver_probe_device+0x164/0x230
> [   43.316337][    T1]  device_driver_attach+0x8c/0xc0
> [   43.318024][    T1]  __driver_attach+0x1e0/0x1f8
> [   43.319584][    T1]  bus_for_each_dev+0xf0/0x188
> [   43.321169][    T1]  driver_attach+0x34/0x40
> [   43.322645][    T1]  bus_add_driver+0x204/0x3c8
> [   43.324202][    T1]  driver_register+0x160/0x1f8
> [   43.325788][    T1]  register_virtio_driver+0x7c/0x88
> [   43.327480][    T1]  virtio_net_driver_init+0xa8/0xf4
> [   43.329196][    T1]  do_one_initcall+0x4c0/0xad8
> [   43.330767][    T1]  kernel_init_freeable+0x3e0/0x500
> [   43.332444][    T1]  kernel_init+0x14/0x1f0
> [   43.333901][    T1]  ret_from_fork+0x10/0x18
>
>
> Cheers,
> Anders
>
> >
> > diff --git a/net/ipv4/ipmr.c b/net/ipv4/ipmr.c
> > index 6e68def66822f47fc08d94eddd32a4bd4f9fdfb0..b6dcdce08f1d82c83756a319623e24ae0174092c 100644
> > --- a/net/ipv4/ipmr.c
> > +++ b/net/ipv4/ipmr.c
> > @@ -94,7 +94,7 @@ static DEFINE_SPINLOCK(mfc_unres_lock);
> >
> >  static struct kmem_cache *mrt_cachep __ro_after_init;
> >
> > -static struct mr_table *ipmr_new_table(struct net *net, u32 id);
> > +static struct mr_table *ipmr_new_table(struct net *net, u32 id, bool init);
> >  static void ipmr_free_table(struct mr_table *mrt);
> >

 static void ip_mr_forward(struct net *net, struct mr_table *mrt,
@@ -110,7 +110,8 @@ static void ipmr_expire_process(struct timer_list *t);

 #ifdef CONFIG_IP_MROUTE_MULTIPLE_TABLES
 #define ipmr_for_each_table(mrt, net) \
-       list_for_each_entry_rcu(mrt, &net->ipv4.mr_tables, list)
+       list_for_each_entry_rcu(mrt, &net->ipv4.mr_tables, list, \
+                               lockdep_rtnl_is_held())
 static struct mr_table *ipmr_mr_table_iter(struct net *net,
                                           struct mr_table *mrt)


Cheers,
Anders

> >  static void ip_mr_forward(struct net *net, struct mr_table *mrt,
> > @@ -245,7 +245,7 @@ static int __net_init ipmr_rules_init(struct net *net)
> >
> >         INIT_LIST_HEAD(&net->ipv4.mr_tables);
> >
> > -       mrt = ipmr_new_table(net, RT_TABLE_DEFAULT);
> > +       mrt = ipmr_new_table(net, RT_TABLE_DEFAULT, true);
> >         if (IS_ERR(mrt)) {
> >                 err = PTR_ERR(mrt);
> >                 goto err1;
> > @@ -322,7 +322,7 @@ static int __net_init ipmr_rules_init(struct net *net)
> >  {
> >         struct mr_table *mrt;
> >
> > -       mrt = ipmr_new_table(net, RT_TABLE_DEFAULT);
> > +       mrt = ipmr_new_table(net, RT_TABLE_DEFAULT, true);
> >         if (IS_ERR(mrt))
> >                 return PTR_ERR(mrt);
> >         net->ipv4.mrt = mrt;
> > @@ -392,7 +392,7 @@ static struct mr_table_ops ipmr_mr_table_ops = {
> >         .cmparg_any = &ipmr_mr_table_ops_cmparg_any,
> >  };
> >
> > -static struct mr_table *ipmr_new_table(struct net *net, u32 id)
> > +static struct mr_table *ipmr_new_table(struct net *net, u32 id, bool init)
> >  {
> >         struct mr_table *mrt;
> >
> > @@ -400,9 +400,11 @@ static struct mr_table *ipmr_new_table(struct net *net, u32 id)
> >         if (id != RT_TABLE_DEFAULT && id >= 1000000000)
> >                 return ERR_PTR(-EINVAL);
> >
> > -       mrt = ipmr_get_table(net, id);
> > -       if (mrt)
> > -               return mrt;
> > +       if (!init) {
> > +               mrt = ipmr_get_table(net, id);
> > +               if (mrt)
> > +                       return mrt;
> > +       }
> >
> >         return mr_table_alloc(net, id, &ipmr_mr_table_ops,
> >                               ipmr_expire_process, ipmr_new_table_set);
> > @@ -1547,7 +1549,7 @@ int ip_mroute_setsockopt(struct sock *sk, int optname, char __user *optval,
> >                 if (sk == rtnl_dereference(mrt->mroute_sk)) {
> >                         ret = -EBUSY;
> >                 } else {
> > -                       mrt = ipmr_new_table(net, uval);
> > +                       mrt = ipmr_new_table(net, uval, false);
> >                         if (IS_ERR(mrt))
> >                                 ret = PTR_ERR(mrt);
> >                         else
> >
> >
