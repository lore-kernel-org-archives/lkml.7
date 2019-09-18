Return-Path: <SRS0=HfRD=XN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AA9BC4CECD
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 00:07:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C34021855
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 00:07:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568765250;
	bh=+NY5WoEAqqS6novROyU2f32JAJvctxG3luGJQz6X+jY=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=paOrLY516t3ajhYhYM8H50Bi7oJe9+bkFpTxxIez//Oa6+QLCp1tz+4LalM11A+Ft
	 lEfWL2ygUTSER2qRYxfT1EERj/HLMayf/YiBMuTZvfMyiV/M4IsOIEqtji/q3oTDAa
	 svrJsQueetgX5vyaK1RjG0UKQKyri0Rx1W0/Pvyw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728642AbfIRAH3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Sep 2019 20:07:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:54840 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725943AbfIRAH3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 20:07:29 -0400
Received: from paulmck-ThinkPad-P72 (96-84-246-146-static.hfc.comcastbusiness.net [96.84.246.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 538C121848;
        Wed, 18 Sep 2019 00:07:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568765248;
        bh=+NY5WoEAqqS6novROyU2f32JAJvctxG3luGJQz6X+jY=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=zsANeLU6Cz3RIwa319k0IjYHwrQrjrJm/ziAt0SMJn6F6RUT0aEc5Es4qyLAHMVq+
         sZ54Gdu0Yh386yEI719OgSoxaXkMihgXI0kyryqCdn0JNlmjrxMkPFo9YkLM65AK8x
         FtbAPm44NEWvdZQ0fp0vdrSmx33BUJbCMbo9IdBA=
Date:   Tue, 17 Sep 2019 17:07:26 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: Re: Build regressions/improvements in v5.3
Message-ID: <20190918000726.GD30224@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20190916065853.12394-1-geert@linux-m68k.org>
 <CAMuHMdVO6S_U96O6VYgK3xaDPhsT_X=O9ibGfCqKjBGcFgmyLg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdVO6S_U96O6VYgK3xaDPhsT_X=O9ibGfCqKjBGcFgmyLg@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 16, 2019 at 10:19:08AM +0200, Geert Uytterhoeven wrote:
> On Mon, Sep 16, 2019 at 9:43 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > JFYI, when comparing v5.3[1] to v5.3-rc8[3], the summaries are:
> >   - build errors: +0/-0
> >   - build warnings: +50/-50
> 
> Just the levelspread noise.
> Anyone with an idea to get rid of it (and to prove they're all false-positives)?
> 
> > [1] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/4d856f72c10ecb060868ed10ff1b1453943fc6c8/ (all 242 configs)
> > [3] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/f74c2bb98776e2de508f4d607cd519873065118e/ (all 242 configs)
> 
> > 122 warning regressions:
> 
> >   + /kisskb/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U aa0>]' may be used uninitialized in this function [-Wuninitialized]:  => 121:34

Looks to me like rcu_init_levelspread() unconditionally initializes all
of the elements.  I suppose that I could stomp the unused portion of
the array, as in the following (untested) patch.

Thoughts?

							Thanx, Paul

------------------------------------------------------------------------

diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
index aeec70f..ab504fb 100644
--- a/kernel/rcu/rcu.h
+++ b/kernel/rcu/rcu.h
@@ -299,6 +299,8 @@ static inline void rcu_init_levelspread(int *levelspread, const int *levelcnt)
 {
 	int i;
 
+	for (i = 0; i < RCU_NUM_LVLS; i++)
+		levelspread[i] = INT_MIN;
 	if (rcu_fanout_exact) {
 		levelspread[rcu_num_lvls - 1] = rcu_fanout_leaf;
 		for (i = rcu_num_lvls - 2; i >= 0; i--)
