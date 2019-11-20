Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D75FFC43215
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 15:53:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3EF320672
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 15:53:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731396AbfKTPxa convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 10:53:30 -0500
Received: from mx1.unisoc.com ([222.66.158.135]:32237 "EHLO
        SHSQR01.spreadtrum.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728453AbfKTPx3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 10:53:29 -0500
Received: from ig2.spreadtrum.com (bjmbx02.spreadtrum.com [10.0.64.8])
        by SHSQR01.spreadtrum.com with ESMTPS id xAKFplbr095330
        (version=TLSv1 cipher=AES256-SHA bits=256 verify=NO);
        Wed, 20 Nov 2019 23:51:47 +0800 (CST)
        (envelope-from Orson.Zhai@unisoc.com)
Received: from spreadtrum.com (10.0.74.112) by BJMBX02.spreadtrum.com
 (10.0.64.8) with Microsoft SMTP Server (TLS) id 15.0.847.32; Wed, 20 Nov 2019
 23:51:36 +0800
Date:   Wed, 20 Nov 2019 23:49:28 +0800
From:   Orson Zhai <orson.zhai@spreadtrum.com>
To:     Arnd Bergmann <arnd@arndb.de>
CC:     Orson Zhai <orson.zhai@unisoc.com>,
        Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        DTML <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        <kevin.tang@unisoc.com>
Subject: Re: [PATCH 1/2] dt-bindings: Add syscon-names support
Message-ID: <20191120154928.GC6039@spreadtrum.com>
References: <20191114114525.12675-1-orson.zhai@unisoc.com>
 <20191114114525.12675-2-orson.zhai@unisoc.com>
 <CAK8P3a23jcNgFErik1PFr=tG6n8kc8Pj9fARw47n=ou8t8iV+Q@mail.gmail.com>
 <20191118083952.GB6039@spreadtrum.com>
 <CAK8P3a2d2=BejX=R0jmw0zt64mPF-rjKSi1Eh5Koz1cqku-nRA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <CAK8P3a2d2=BejX=R0jmw0zt64mPF-rjKSi1Eh5Koz1cqku-nRA@mail.gmail.com>
X-Mailer: git-send-email 2.18.0
X-Originating-IP: [10.0.74.112]
X-ClientProxiedBy: SHCAS03.spreadtrum.com (10.0.1.207) To
 BJMBX02.spreadtrum.com (10.0.64.8)
Content-Transfer-Encoding: 8BIT
X-MAIL: SHSQR01.spreadtrum.com xAKFplbr095330
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

On Tue, Nov 19, 2019 at 03:46:09PM +0100, Arnd Bergmann wrote:
> On Mon, Nov 18, 2019 at 9:42 AM Orson Zhai <orson.zhai@spreadtrum.com> wrote:
> >
> > Hi Arnd,
> >
> > On Fri, Nov 15, 2019 at 10:33:30AM +0100, Arnd Bergmann wrote:
> > > On Thu, Nov 14, 2019 at 12:48 PM Orson Zhai <orson.zhai@unisoc.com> wrote:
> > > >
> > > >
> > > > Make life easier when syscon consumer want to access multiple syscon
> > > > nodes.
> > > > Add syscon-names and relative properties to help manage complicated
> > > > cases when accessing more one syscon node.
> > > >
> > > > Signed-off-by: Orson Zhai <orson.zhai@unisoc.com>
> > >
> > > Hi Orson,
> > >
> > > Can you explain why the number of cells in this binding is specific
> > > to the syscon node rather than the node referencing it?
> >
> > The story is like this. I found there are too many global registers in
> > Unisoc(former Spreadtrum) chips. Dozens of offset with dozens of modules
> > were needed to be specified. So I thought the dts files would seem "horrible"
> > with a big chunk of syscon-xxx (say more than 20 lines)
> >
> > I learned from reg-names way which might look clean to hold all these mess things.
> > But to implement this, the users need to konw the cell-size if we add arguments to syscon node.
> > I thought to add cell-size into every syscon consumer node is a duplicated work and
> > I wanted to take advantage of of_parse_phandle_with_args.
> > So the bindings were created then.
>
> Ok, that makes sense.
>
> > > The way would otherwise handle the example from your binding
> > > would be with two separate properties in the display node, like
> > >
> > > syscon-enable = <&ap_apb_regs 0x4 0xf00>;
> > > syscon-power = <&aon_regs 0x8>;
> >
> > This is an option for consumers all the time.
> > Acturally my patches are not going to replace this.
> > I'd like to provide another option to save people like desperate engineers in Spreadtrum :)
> >
> > >
> > > in which case, the syscon driver does not need to know anything
> >
> > Whould it be better if I add syscon-cells into consumer's node?
>
> As I see it, there is no reason to put the syscon-cells property into any node,
> as this is implied by the driver binding using the syscon reference.  I would
> only use the #xyz-cells style property if there are multiple interpretations
> that all make sense for the same binding.
>
> > Then I could read the cell size and use "of_parse_phandle_with_fixed_args()" instead.
> > This will not involve syscon node itself at all.
>
> This sounds better to me, yes. I had not even remembered this function
> exists, but I think this is a good idea.
>
> I can also see a point in favor of adding more infrastructure around this,
> possibly naming the entries in a syscon-names property as you suggested,
> combining of_parse_phandle_with_fixed_args() with a name, or
> combining with syscon_regmap_lookup_by_phandle() for convenience.
>
> This should all be possible without adding complexity to the syscon
> DT binding itself, and it would give more structure to the way it
> is used by drivers.

V2 has been sent out per as you suggested.

Free free to review please.

Best Regards,
-Orson
>
>        Arnd
________________________________
 This email (including its attachments) is intended only for the person or entity to which it is addressed and may contain information that is privileged, confidential or otherwise protected from disclosure. Unauthorized use, dissemination, distribution or copying of this email or the information herein or taking any action in reliance on the contents of this email or the information herein, by anyone other than the intended recipient, or an employee or agent responsible for delivering the message to the intended recipient, is strictly prohibited. If you are not the intended recipient, please do not read, copy, use or disclose any part of this e-mail to others. Please notify the sender immediately and permanently delete this e-mail and any attachments if you received it in error. Internet communications cannot be guaranteed to be timely, secure, error-free or virus-free. The sender does not accept liability for any errors or omissions.
本邮件及其附件具有保密性质，受法律保护不得泄露，仅发送给本邮件所指特定收件人。严禁非经授权使用、宣传、发布或复制本邮件或其内容。若非该特定收件人，请勿阅读、复制、 使用或披露本邮件的任何内容。若误收本邮件，请从系统中永久性删除本邮件及所有附件，并以回复邮件的方式即刻告知发件人。无法保证互联网通信及时、安全、无误或防毒。发件人对任何错漏均不承担责任。
