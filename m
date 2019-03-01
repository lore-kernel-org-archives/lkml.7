Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1794DC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 21:54:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0A992083E
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 21:54:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="SHpQY77t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726865AbfCAVyX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 16:54:23 -0500
Received: from a9-33.smtp-out.amazonses.com ([54.240.9.33]:57644 "EHLO
        a9-33.smtp-out.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725905AbfCAVyW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 16:54:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=ug7nbtf4gccmlpwj322ax3p6ow6yfsug; d=amazonses.com; t=1551477261;
        h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:MIME-Version:Content-Type:Feedback-ID;
        bh=2Jc/tSP1ABqcl4cd1GgSVzoA/Kx4tApyrDVy0ryamn0=;
        b=SHpQY77tA+lD6XMnqdJMJV2eABN9q78u3jxFx8zlSpURu5PzKWQkLAKYg2oR3TlS
        2+Le5kDQ6R7EjTXF6uzU5wFV0NPHkTDB65mY6Guv1rzbv38DSqJIOE4vpWvUTQAMOhZ
        t3Tm8NNMilcK5L/+qtZZJOcGBANEB088JCtpAnOI=
Date:   Fri, 1 Mar 2019 21:54:21 +0000
From:   Christopher Lameter <cl@linux.com>
X-X-Sender: cl@nuc-kabylake
To:     Barret Rhoden <brho@google.com>
cc:     Dennis Zhou <dennis@kernel.org>, Eial Czerwacki <eial@scalemp.com>,
        tj@kernel.org, linux-kernel@vger.kernel.org,
        Shai Fultheim <shai@scalemp.com>,
        Oren Twaig <oren@scalemp.com>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: Re: [PATCH] percpu/module resevation: change resevation size iff
 X86_VSMP is set
In-Reply-To: <c72402f2-967e-cd56-99d8-9139c9e7f267@google.com>
Message-ID: <010001693b404440-248fa987-624c-4587-940b-56e2ed4226d9-000000@email.amazonses.com>
References: <1548071251-1849-1-git-send-email-eial@scalemp.com> <a7eff2ed-0e80-edae-2a97-a3fdab2d05f5@google.com> <20190301203455.GA97188@dennisz-mbp.dhcp.thefacebook.com> <c72402f2-967e-cd56-99d8-9139c9e7f267@google.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-SES-Outgoing: 2019.03.01-54.240.9.33
Feedback-ID: 1.us-east-1.fQZZZ0Xtj2+TD7V5apTT/NrT6QKuPgzCT/IC7XYgDKI=:AmazonSES
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 1 Mar 2019, Barret Rhoden wrote:

> I'm not familiar with VSMP - how bad is it to use L1 cache alignment instead
> of 4K page alignment?  Maybe some structures can use the smaller alignment?
> Or maybe have VSMP require SRCU-using modules to be built-in?

It is very expensive. VMSP exchanges 4K segments via RDMA between servers
to build a large address space and run a kernel in the large address
space. Using smaller segments can cause a lot of
"cacheline" bouncing (meaning transfers of 4K segments back and forth
between servers).
