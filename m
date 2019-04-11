Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4885AC10F11
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 00:50:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE90320663
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 00:50:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=themaw.net header.i=@themaw.net header.b="QKJZTDNP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DdZP7Qg6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726831AbfDKAuY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 20:50:24 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:51257 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725782AbfDKAuX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 20:50:23 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 29BC321687;
        Wed, 10 Apr 2019 20:50:22 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Wed, 10 Apr 2019 20:50:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=
        message-id:subject:from:to:cc:date:in-reply-to:references
        :content-type:mime-version:content-transfer-encoding; s=fm2; bh=
        VNHzEkSAdnkBEisVXTY5QDMcCIK0gyWcq96ri9B6hJU=; b=QKJZTDNPQx1s6x/q
        7BVe+B3lCq/uPu9Ot1CoyhoJlyAtmquVrzoxdv5kWP/zUHbiK7RSi9gy7eIAXT1n
        oS3QzKyB3UOn/z/7Q0/GwHqpS41VVjOuCLp2RqYkvNBCAgZUFIufVpLja9sW+CnH
        8sKThxuSmoEcomEkVVsBYuiyNa8wXDqJw2hvVdomZwTNHxNLvnJmuR5/oPNJ6oG6
        FKM3etkKj/fdbW1I+w1xb9NK18+Eyd0EojLUxPN1GVWYHR4+we5ob/c2iTD2Ec2a
        Sl5CDtJzS+zmePVVj/GAjtYkBlpHpfK5/V5LOm5LtVsfgDIh2S1KCbIGRpI6PK9d
        oxlkIA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; bh=VNHzEkSAdnkBEisVXTY5QDMcCIK0gyWcq96ri9B6h
        JU=; b=DdZP7Qg65f85ykJuw66rWNPvQ+FmDo+NMEwvYgt4w8UeZaCoJ3rTkjNrP
        oyuRR5W9MAWg8TGR0mItI4QO3gNJdYlDPAu15zfSUTueaWN+jnk9umbxRVvd0doq
        eGFbSUH2aUzvnBFIknfzWhdBTAvAXSBdvBpozyzveDeXTdgI6yVqrLmWnZe+EvcL
        26NtNYRcjuYCiKJS/NS4sEBWX6hELdR6QH39LqPBqaO34MUMwBBDlOqg6s2JAOoU
        /gXiMqynVz0z83mGakFrx8lPb/krA/6tRsFNQ1BQD4q5ZmveUJhlahwd3nIMUnn9
        SV0091nOwR+B8oaPncYu00957SvPw==
X-ME-Sender: <xms:TY-uXOJZ-vvy23wo0JC5_aMNF6at3wL24AbMfD1cpymh_6iW76sVbA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduuddrudekgdefgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefkuffhvfffjghftgfoggfgsehtjeertdertdejnecuhfhrohhmpefkrghnucfm
    vghnthcuoehrrghvvghnsehthhgvmhgrfidrnhgvtheqnecukfhppeduudekrddvtdekrd
    eifedrvdefvdenucfrrghrrghmpehmrghilhhfrhhomheprhgrvhgvnhesthhhvghmrgif
    rdhnvghtnecuvehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:TY-uXHHP6UrXKtKL1uN74kVZbtNlXUouc9nx621WMsuQRzkpzPMo0A>
    <xmx:TY-uXPDexQ7KTa9SanNaSDcVgldUeGCQj0Saiz__nbHMx1J_rLIUdA>
    <xmx:TY-uXB1WTWPw8t5vxyFP8cAx8EJ2oKMI5pr9E0dniL2q19B8ci7_Cg>
    <xmx:To-uXAaVbtZTNM_scuF2YkusH8IYcGps16qBAnBGtnndIR1-2KQtAg>
Received: from pluto.themaw.net (unknown [118.208.63.232])
        by mail.messagingengine.com (Postfix) with ESMTPA id 2B5FCE407B;
        Wed, 10 Apr 2019 20:50:21 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by pluto.themaw.net (Postfix) with ESMTP id BA4861C0117;
        Thu, 11 Apr 2019 08:50:17 +0800 (AWST)
Message-ID: <ed84e67c9cb55e91daf0d090152b3a9e2e06fe0b.camel@themaw.net>
Subject: Re: kernel BUG at fs/inode.c:LINE!
From:   Ian Kent <raven@themaw.net>
To:     Dmitry Vyukov <dvyukov@google.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Cc:     syzbot <syzbot+5399ed0832693e29f392@syzkaller.appspotmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Amir Goldstein <amir73il@gmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Date:   Thu, 11 Apr 2019 08:50:17 +0800
In-Reply-To: <CACT4Y+bc=A=djKChMkJGwXYbZ7UXuxmRu5Z0Y1BEXAFH1-Z6Kw@mail.gmail.com>
References: <00000000000051e9c2057d31a563@google.com>
         <00000000000036a4a9058619dff3@google.com>
         <20190410002603.GS2217@ZenIV.linux.org.uk>
         <CACT4Y+YurDDxvvd2MbOf8pGyA0B+W_EFB34oVAcHXyv-ApKC7Q@mail.gmail.com>
         <eb223b47641df91a56fd200188a65d2c0ca4abe1.camel@themaw.net>
         <CACT4Y+YdaDdDbRvQZzvqbPofMD6F9cPtGFzcW+db-etJayfaJw@mail.gmail.com>
         <5c581e6eadc946b965e3138c9daffda75b1fba56.camel@themaw.net>
         <1f1d3b95189b6b8acfdf61dd05a804744791d313.camel@themaw.net>
         <20190410121159.GY2217@ZenIV.linux.org.uk>
         <CACT4Y+bc=A=djKChMkJGwXYbZ7UXuxmRu5Z0Y1BEXAFH1-Z6Kw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-2.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-04-10 at 14:41 +0200, Dmitry Vyukov wrote:
> On Wed, Apr 10, 2019 at 2:12 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
> > 
> > On Wed, Apr 10, 2019 at 08:07:15PM +0800, Ian Kent wrote:
> > 
> > > > I'm unable to find a branch matching the line numbers.
> > > > 
> > > > Given that, on the face of it, the scenario is impossible I'm
> > > > seeking clarification on what linux-next to look at for the
> > > > sake of accuracy.
> > > > 
> > > > So I'm wondering if this testing done using the master branch
> > > > or one of the daily branches one would use to check for conflicts
> > > > before posting?
> > > 
> > > Sorry those are tags not branches.
> > 
> > FWIW, that's next-20181214; it is what master had been in mid-December
> > and master is rebased every day.  Can it be reproduced with the current
> > tree?
> 
> From the info on the dashboard we know that it happened only once on
> d14b746c (the second one is result of reproducing the first one). So
> it was either fixed or just hard to trigger.

Looking at the source of tag next-20181214 in linux-next-history I see
this is mistake I made due to incorrect error handling which I fixed
soon after (there was in fact a double iput()).

I'm pretty sure this never made it to a released kernel so unless
there's a report of this in a stable released kernel I'm going to
move on.

Thanks
Ian

