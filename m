Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03AFBC4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 06:10:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D110920652
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 06:10:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728425AbfCFGKO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 01:10:14 -0500
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:17939 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727452AbfCFGKN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 01:10:13 -0500
X-IronPort-AV: E=Sophos;i="5.58,446,1544482800"; 
   d="scan'208";a="372109852"
Received: from abo-58-107-68.mrs.modulonet.fr (HELO hadrien) ([85.68.107.58])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Mar 2019 07:10:09 +0100
Date:   Wed, 6 Mar 2019 07:10:09 +0100 (CET)
From:   Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To:     wen.yang99@zte.com.cn
cc:     linux@armlinux.org.uk, linus.walleij@linaro.org,
        Julia Lawall <julia.lawall@lip6.fr>, tomi.valkeinen@ti.com,
        linux-kernel@vger.kernel.org, wang.yi59@zte.com.cn,
        afaerber@suse.de, manivannan.sadhasivam@linaro.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 01/15] ARM: actions: fix a leaked reference by
 addingmissing of_node_put
In-Reply-To: <201903061118011200191@zte.com.cn>
Message-ID: <alpine.DEB.2.21.1903060704040.2706@hadrien>
References: <201903061118011200191@zte.com.cn>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-584560884-1551852609=:2706"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-584560884-1551852609=:2706
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Wed, 6 Mar 2019, wen.yang99@zte.com.cn wrote:

> On Tue, Mar 05, 2019 at 07:41 PM +0800, RussellKing wrote:
> > Subject: Re: [PATCH v2 01/15] ARM: actions: fix a leaked reference by addingmissing of_node_put
> > On Tue, Mar 05, 2019 at 07:33:52PM +0800, Wen Yang wrote:
> > > The call to of_get_next_child returns a node pointer with refcount
> > > incremented thus it must be explicitly decremented after the last
> > > usage.
> > >
> > > Detected by coccinelle with the following warnings:
> > > ./arch/arm/mach-actions/platsmp.c:112:2-8: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 103, but without a corresponding object release within this function.
> > > ./arch/arm/mach-actions/platsmp.c:124:2-8: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 115, but without a corresponding object release within this function.
> > > ./arch/arm/mach-actions/platsmp.c:137:3-9: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 128, but without a corresponding object release within this function.
> >
> > I question this.  Your reasoning is that the node is no longer used
> > so the reference count needs to be put.

Is the concern about the warning message?  Or will doing the put cause an
error?  Or is the concern that adding the put will clutter the code or
cause unwanted churn?  I see that you say below that having the count hit
0 would be a bug, but would it actually hit 0, since there has been a get
in all of the accessing function calls?  The semantic patch that produces
the message requires that the device node is only stored in a local
variable, so the current access to it will not be accessible any more when
the function is over.

The version of the semantic patch that Wen Yang is currently working
on, also checks that there is a put of the same data elsewhere in the
function, so perhaps that will alleviate the concern about puts where they
are not needed, while still making it possible to find the ones that are
needed.

thanks,
julia

> >
> > However, in all these cases, data is read from the nodes properties
> > and the device remains in-use for the life of the kernel.  There is
> > a big difference here.
> >
> > With normal drivers, each device is bound to their associated device
> > node associated with the device.  When the device node goes away, then
> > the corresponding device goes away too, which causes the driver to be
> > unbound from the device.
> >
> > However, there is another class of "driver" which are the ones below,
> > where they are "permanent" devices.  These can never go away, even if
> > the device node refcount hits zero and the device node is freed - the
> > device is still present and in-use in the system.
>
> Hi Russel,
> Thank you very much for your comments.
> The problem we want to solve is "fix the reference leaks of device_node".
> We use the following coccinelle script to achieve the goal:
> @search exists@
> local idexpression struct device_node * node;
> expression e, e1;
> position p1,p2;
> type T,T1,T2;
> @@
>
> node = @p1\(of_find_compatible_node\|of_find_node_by_name\|of_parse_phandle\|
>     of_find_node_by_type\|of_find_node_by_name\|of_find_all_nodes\|
>     of_get_cpu_node\|of_get_parent\|of_get_next_parent\|
>     of_get_next_child\|of_get_next_available_child\|of_get_next_cpu_node\|
>     of_get_compatible_child\|of_get_child_by_name\|of_find_node_opts_by_path\|
>     of_find_node_with_property\|of_find_matching_node_and_match\|of_find_node_by_phandle\|
>     of_parse_phandle\)(...)
> ... when != e = (T)node
> if (node == NULL || ...) { ... return ...; }
> ... when != of_node_put(node)
>     when != if (node) { ... of_node_put(node) ... }
>     when != e1 = (T1)node
> (
>   return (T2)node;
> | return@p2 ...;
> )
>
> Using the script above, we found the issues for this file in the patch:
> arch/arm/mach-actions/platsmp.c
> 99 static void __init s500_smp_prepare_cpus(unsigned int max_cpus)
> 100 {
> 101 struct device_node *node;
> 102
> 103 node = of_find_compatible_node(NULL, NULL, "actions,s500-timer");
> ...
> 109 timer_base_addr = of_iomap(node, 0);
> 110 if (!timer_base_addr) {
> 111 pr_err("%s: could not map timer registers\n", __func__);
> 112 return;
> 113 }
> 114
> 115 node = of_find_compatible_node(NULL, NULL, "actions,s500-sps");
> ...
>
> The comment for of_find_compatible_node writes:
> “Returns a node pointer with refcount incremented, use of_node_put() on it when done.”
> the node is a local variable obtained by of_find_compatible_node.
> But the code does not call on_node_put() to reduce the reference count,
> the function returns directly, or directly reassigns it.
> This leads to a reference leak.
>
> >  So, having the
> > device node refcount hit zero is actually a bug: what that's saying
> > is the system device (eg, SCU) has gone away.  If you somehow were to
> > remove the SCU from the system, you'd end up severing the connection
> > between the CPU cores and the rest of the system - obviously resulting
> > in a dead system!
> > So, what is the point of dropping these refcounts for devices that can
> > never go away - and thus their associated device_node should also never
> > go away?
>
> Thank you very much.
> Here we may have a little different opinion:
> If we really need to keep a reference to the node,
> we should probably change the node (a local variable ) to a static or global variable
> to explicitly hold the reference,  so that the memory can be cleaned when the system exits.
>
> Thanks and regards,
> Wen
>
> > >
> > > Signed-off-by: Wen Yang
> > > Reviewed-by: Florian Fainelli
> > > Cc: "Andreas Färber"
> > > Cc: Manivannan Sadhasivam
> > > Cc: Russell King
> > > Cc: linux-arm-kernel@lists.infradead.org
> > > Cc: linux-kernel@vger.kernel.org
> > > ---
> > > v2->v1: add a missing space between "adding" and "missing"
> > >
> > >  arch/arm/mach-actions/platsmp.c | 3 +++
> > >  1 file changed, 3 insertions(+)
> > >
> > > diff --git a/arch/arm/mach-actions/platsmp.c b/arch/arm/mach-actions/platsmp.c
> > > index 4fd479c..1a8e078 100644
> > > --- a/arch/arm/mach-actions/platsmp.c
> > > +++ b/arch/arm/mach-actions/platsmp.c
> > > @@ -107,6 +107,7 @@ static void __init s500_smp_prepare_cpus(unsigned int max_cpus)
> > >      }
> > >
> > >      timer_base_addr = of_iomap(node, 0);
> > > +    of_node_put(node);
> > >      if (!timer_base_addr) {
> > >          pr_err("%s: could not map timer registers\n", __func__);
> > >          return;
> > > @@ -119,6 +120,7 @@ static void __init s500_smp_prepare_cpus(unsigned int max_cpus)
> > >      }
> > >
> > >      sps_base_addr = of_iomap(node, 0);
> > > +    of_node_put(node);
> > >      if (!sps_base_addr) {
> > >          pr_err("%s: could not map sps registers\n", __func__);
> > >          return;
> > > @@ -132,6 +134,7 @@ static void __init s500_smp_prepare_cpus(unsigned int max_cpus)
> > >          }
> > >
> > >          scu_base_addr = of_iomap(node, 0);
> > > +        of_node_put(node);
> > >          if (!scu_base_addr) {
> > >              pr_err("%s: could not map scu registers\n", __func__);
> > >              return;
> > > --
> > > 2.9.5
> > >
> > >
--8323329-584560884-1551852609=:2706--
