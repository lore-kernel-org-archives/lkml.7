Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D43CBECE58C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 17:56:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A872020684
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 17:56:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pimaker.at header.i=@pimaker.at header.b="Y3iJ/ujK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729500AbfJGR4p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 13:56:45 -0400
Received: from mail2.protonmail.ch ([185.70.40.22]:60810 "EHLO
        mail2.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729189AbfJGR4o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 13:56:44 -0400
Date:   Mon, 07 Oct 2019 17:56:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pimaker.at;
        s=protonmail; t=1570471001;
        bh=eJ5MtFPu12WNiGiJIVRCOx1RxauP5/FllS4pi3PUTgM=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:
         Feedback-ID:From;
        b=Y3iJ/ujK5shcW6Sp0D4soqPfLnJZZ8E1QXenxGeuHROf8XPjzKZjCi03sF7Ms2B/D
         Tl70Og8IYZs4x9QoUVbSviwnom0xIxNfacQY+3cg2Hv1f4PbKgrd/x7SWjj7zlAcZK
         IRCCM/psXA6hwaCx+zsvldGxIAUvcFBpBaHYFOZ4=
To:     paulmck@kernel.org
From:   Stefan <stefan@pimaker.at>
Cc:     rcu@vger.kernel.org, Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        linux-kernel@vger.kernel.org
Reply-To: Stefan <stefan@pimaker.at>
Subject: Re: [PATCH] rcu/nocb: Fix dump_tree hierarchy print always active
Message-ID: <d74644c4-9bdc-a21c-acc2-a8f525863064@pimaker.at>
In-Reply-To: <20191007012625.GA23446@paulmck-ThinkPad-P72>
References: <20191004194854.11352-1-stefan@pimaker.at>
 <20191004222402.GQ2689@paulmck-ThinkPad-P72>
 <20191007012625.GA23446@paulmck-ThinkPad-P72>
Feedback-ID: ue9Y3QtBlktHf6EEpXP3zzomX_ELv4nrMskJ1DJAqtnBErUqnmreyaap-KHUztlMofpS6GrkVvbLJ97c2ByOFQ==:Ext:ProtonMail
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/10/2019 03:26, Paul E. McKenney wrote:
>=20
> On Fri, Oct 04, 2019 at 03:24:02PM -0700, Paul E. McKenney wrote:
>> On Fri, Oct 04, 2019 at 07:49:10PM +0000, Stefan Reiter wrote:
>>> Commit 18cd8c93e69e ("rcu/nocb: Print gp/cb kthread hierarchy if
>>> dump_tree") added print statements to rcu_organize_nocb_kthreads for
>>> debugging, but incorrectly guarded them, causing the function to always
>>> spew out its message.
>>>
>>> This patch fixes it by guarding both pr_alert statements with dump_tree=
,
>>> while also changing the second pr_alert to a pr_cont, to print the
>>> hierarchy in a single line (assuming that's how it was supposed to
>>> work).
>>>
>>> Fixes: 18cd8c93e69e ("rcu/nocb: Print gp/cb kthread hierarchy if dump_t=
ree")
>>> Signed-off-by: Stefan Reiter <stefan@pimaker.at>
>>
>> Queued for testing and review, thank you!
>=20
> And here is an updated version to make the special case of a nocb GP
> kthread having no other nocb CB kthreads look less strange.  Does this
> work for you?

Tested just now, works for me. Thanks for the additional fix!

>=20
> =09=09=09=09=09=09=09Thanx, Paul
>=20
> ------------------------------------------------------------------------
>=20
> commit e6223b0705369750990c32ddc80251942e61be30
> Author: Stefan Reiter <stefan@pimaker.at>
> Date:   Fri Oct 4 19:49:10 2019 +0000
>=20
>      rcu/nocb: Fix dump_tree hierarchy print always active
>=20
>      Commit 18cd8c93e69e ("rcu/nocb: Print gp/cb kthread hierarchy if
>      dump_tree") added print statements to rcu_organize_nocb_kthreads for
>      debugging, but incorrectly guarded them, causing the function to alw=
ays
>      spew out its message.
>=20
>      This patch fixes it by guarding both pr_alert statements with dump_t=
ree,
>      while also changing the second pr_alert to a pr_cont, to print the
>      hierarchy in a single line (assuming that's how it was supposed to
>      work).
>=20
>      Fixes: 18cd8c93e69e ("rcu/nocb: Print gp/cb kthread hierarchy if dum=
p_tree")
>      Signed-off-by: Stefan Reiter <stefan@pimaker.at>
>      [ paulmck: Make single-nocbs-CPU GP kthreads look less erroneous. ]
>      Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
>=20
> diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
> index d5334e4..d43f4e0 100644
> --- a/kernel/rcu/tree_plugin.h
> +++ b/kernel/rcu/tree_plugin.h
> @@ -2295,6 +2295,8 @@ static void __init rcu_organize_nocb_kthreads(void)
>   {
>   =09int cpu;
>   =09bool firsttime =3D true;
> +=09bool gotnocbs =3D false;
> +=09bool gotnocbscbs =3D true;
>   =09int ls =3D rcu_nocb_gp_stride;
>   =09int nl =3D 0;  /* Next GP kthread. */
>   =09struct rcu_data *rdp;
> @@ -2317,21 +2319,31 @@ static void __init rcu_organize_nocb_kthreads(voi=
d)
>   =09=09rdp =3D per_cpu_ptr(&rcu_data, cpu);
>   =09=09if (rdp->cpu >=3D nl) {
>   =09=09=09/* New GP kthread, set up for CBs & next GP. */
> +=09=09=09gotnocbs =3D true;
>   =09=09=09nl =3D DIV_ROUND_UP(rdp->cpu + 1, ls) * ls;
>   =09=09=09rdp->nocb_gp_rdp =3D rdp;
>   =09=09=09rdp_gp =3D rdp;
> -=09=09=09if (!firsttime && dump_tree)
> -=09=09=09=09pr_cont("\n");
> -=09=09=09firsttime =3D false;
> -=09=09=09pr_alert("%s: No-CB GP kthread CPU %d:", __func__, cpu);
> +=09=09=09if (dump_tree) {
> +=09=09=09=09if (!firsttime)
> +=09=09=09=09=09pr_cont("%s\n", gotnocbscbs
> +=09=09=09=09=09=09=09? "" : " (self only)");
> +=09=09=09=09gotnocbscbs =3D false;
> +=09=09=09=09firsttime =3D false;
> +=09=09=09=09pr_alert("%s: No-CB GP kthread CPU %d:",
> +=09=09=09=09=09 __func__, cpu);
> +=09=09=09}
>   =09=09} else {
>   =09=09=09/* Another CB kthread, link to previous GP kthread. */
> +=09=09=09gotnocbscbs =3D true;
>   =09=09=09rdp->nocb_gp_rdp =3D rdp_gp;
>   =09=09=09rdp_prev->nocb_next_cb_rdp =3D rdp;
> -=09=09=09pr_alert(" %d", cpu);
> +=09=09=09if (dump_tree)
> +=09=09=09=09pr_cont(" %d", cpu);
>   =09=09}
>   =09=09rdp_prev =3D rdp;
>   =09}
> +=09if (gotnocbs && dump_tree)
> +=09=09pr_cont("%s\n", gotnocbscbs ? "" : " (self only)");
>   }
>=20
>   /*
>=20

