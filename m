Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD2AFC432C3
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 21:19:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 846AC2230D
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 21:19:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fWaHUwDb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727053AbfKRVTi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 16:19:38 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:44850 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726664AbfKRVTi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 16:19:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574111976;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QO4lehuxy6RLC/M2Uonk83EBzWJAxoHvNtM3xVNrxjo=;
        b=fWaHUwDbgySIRbP0F/xFKyqIy59NkE3SOdzvCZiOkgquqIKsVEFCnjf8PawyiF4hnctt7I
        gpFTJ/VYWuoruMdccodlnmRy+/LLCiYizMYUXTr7osINBo9J2CIgDz0rAslsTh2WXP51B+
        EEJvCqJoXejK25qq8Miz0BU1o59rQco=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-231-PShu_lh4P7OwHtveNvv70g-1; Mon, 18 Nov 2019 16:19:33 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C6DAA8E8041;
        Mon, 18 Nov 2019 21:19:31 +0000 (UTC)
Received: from dhcp-25.97.bos.redhat.com (unknown [10.18.25.127])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 05A6860BE1;
        Mon, 18 Nov 2019 21:19:29 +0000 (UTC)
From:   Aaron Conole <aconole@redhat.com>
To:     Nicolas Dichtel <nicolas.dichtel@6wind.com>
Cc:     netdev@vger.kernel.org, Pravin B Shelar <pshelar@ovn.org>,
        "David S . Miller" <davem@davemloft.net>,
        Jamal Hadi Salim <jhs@mojatatu.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Jiri Pirko <jiri@resnulli.us>, dev@openvswitch.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 1/2] openvswitch: support asymmetric conntrack
References: <20191108210714.12426-1-aconole@redhat.com>
        <eb0bdc35-7f29-77c7-c013-e88f74772c24@6wind.com>
Date:   Mon, 18 Nov 2019 16:19:29 -0500
In-Reply-To: <eb0bdc35-7f29-77c7-c013-e88f74772c24@6wind.com> (Nicolas
        Dichtel's message of "Tue, 12 Nov 2019 09:52:45 +0100")
Message-ID: <f7tsgmkyja6.fsf@dhcp-25.97.bos.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: PShu_lh4P7OwHtveNvv70g-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Nicolas Dichtel <nicolas.dichtel@6wind.com> writes:

> Le 08/11/2019 =C3=A0 22:07, Aaron Conole a =C3=A9crit=C2=A0:
>> The openvswitch module shares a common conntrack and NAT infrastructure
>> exposed via netfilter.  It's possible that a packet needs both SNAT and
>> DNAT manipulation, due to e.g. tuple collision.  Netfilter can support
>> this because it runs through the NAT table twice - once on ingress and
>> again after egress.  The openvswitch module doesn't have such capability=
.
>>=20
>> Like netfilter hook infrastructure, we should run through NAT twice to
>> keep the symmetry.
>>=20
>> Fixes: 05752523e565 ("openvswitch: Interface with NAT.")
>> Signed-off-by: Aaron Conole <aconole@redhat.com>
> In this case, ovs_ct_find_existing() won't be able to find the
> conntrack, right?

vswitchd normally won't allow both actions to get programmed.  Even the
kernel module won't allow it, so this really will only happen when the
connection gets established via the nf_hook path, and then needs to be
processed via openvswitch.  In those cases, the tuple lookup should be
correct, because the nf_nat table should contain the correct tuple data,
and the skbuff should have the correct tuples in the packet data to
begin with.

> Inverting the tuple to find the conntrack doesn't work anymore with doubl=
e NAT.
> Am I wrong?

I think since the packet was double-NAT on the way out (via nf_hook
path), then the incoming reply will have the correct NAT tuples and the
lookup will happen just fine.  Just that during processing, both
transformations aren't applied.

Makes sense?

> Regards,
> Nicolas

