Return-Path: <SRS0=WTd2=XW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6559EC4360C
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 18:14:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 363A2217D9
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 18:14:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569608097;
	bh=4sur/3utEGTOycoGH95qWurmb4IQuA8KLFKiKWKmrjg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=oNVHZ8IJ85R13L+crgefyKJeY9qZpIFIObPU4z+eVD0zSQBHAhCJrke45tM8gE6WL
	 4evoZtQvvC1GoArKShH3Sruybm3k911on6tiYzdUlfhd2LtzN5WCdMdMdLvrPuxvaa
	 b5044K/q8dD3XMrvl+/yXcHpWs+Wny8QXzVFU+Ro=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728059AbfI0SO4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Sep 2019 14:14:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:57778 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726294AbfI0SO4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Sep 2019 14:14:56 -0400
Received: from localhost (unknown [62.119.166.9])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D2A02207FF;
        Fri, 27 Sep 2019 18:14:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569608094;
        bh=4sur/3utEGTOycoGH95qWurmb4IQuA8KLFKiKWKmrjg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KLhuMF7+e7tO8IfHcrTbGwBMr5Tv8BMx+E/913PUmWGpkFYZ9Lcx0O63hpdu81sYr
         88ASYgzh3DeOTtSZp1tg/evZxU50VSkRm3ojrWaSCFmsIzcUi+/WrhBhlJZcAFsXAq
         uTKvpOrWyjF5h9Zjq3fhFSgbzN6Oi8By6Fx2Qgxk=
Date:   Fri, 27 Sep 2019 20:14:14 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Matthias Maennich <maennich@google.com>,
        Jessica Yu <jeyu@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Martijn Coenen <maco@android.com>,
        Will Deacon <will.deacon@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 7/7] nsdeps: make generated patches independent of locale
Message-ID: <20190927181414.GB1804168@kroah.com>
References: <20190927093603.9140-1-yamada.masahiro@socionext.com>
 <20190927093603.9140-8-yamada.masahiro@socionext.com>
 <20190927132726.GB187147@google.com>
 <CAK7LNARQZ49jvPOK5Dg3B7Nog7+zHsAn5=1oHH6hz9ZzJ=S+xA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK7LNARQZ49jvPOK5Dg3B7Nog7+zHsAn5=1oHH6hz9ZzJ=S+xA@mail.gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 28, 2019 at 12:42:28AM +0900, Masahiro Yamada wrote:
> On Fri, Sep 27, 2019 at 10:27 PM Matthias Maennich <maennich@google.com> wrote:
> >
> > On Fri, Sep 27, 2019 at 06:36:03PM +0900, Masahiro Yamada wrote:
> > >scripts/nsdeps automatically generates a patch to add MODULE_IMPORT_NS
> > >tags, and what is nicer, it sorts the lines alphabetically with the
> > >"sort" command. However, the output from the "sort" command depends
> > >on locale.
> > >
> > >Especially when namespaces contain underscores, the result is
> > >different depending on the locale.
> > >
> > >For example, I got this:
> > >
> > >$ { echo usbcommon; echo usb_common; } | LANG=en_US.UTF-8 sort
> > >usbcommon
> > >usb_common
> > >$ { echo usbcommon; echo usb_common; } | LANG=C sort
> > >usb_common
> > >usbcommon
> > >
> > >So, this means people might potentially send different patches.
> > >
> > >This kind of issue was reported in the past, for example,
> > >commit f55f2328bb28 ("kbuild: make sorting initramfs contents
> > >independent of locale").
> > >
> > >Adding "LANG=C" is a conventional way of fixing when a deterministic
> > >result is desirable.
> > >
> > >Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> > >---
> > >
> > > scripts/nsdeps | 2 +-
> > > 1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > >diff --git a/scripts/nsdeps b/scripts/nsdeps
> > >index 964b7fb8c546..3754dac13b31 100644
> > >--- a/scripts/nsdeps
> > >+++ b/scripts/nsdeps
> > >@@ -41,7 +41,7 @@ generate_deps() {
> > >               for source_file in $mod_source_files; do
> > >                       sed '/MODULE_IMPORT_NS/Q' $source_file > ${source_file}.tmp
> > >                       offset=$(wc -l ${source_file}.tmp | awk '{print $1;}')
> > >-                      cat $source_file | grep MODULE_IMPORT_NS | sort -u >> ${source_file}.tmp
> > >+                      cat $source_file | grep MODULE_IMPORT_NS | LANG=C sort -u >> ${source_file}.tmp
> >
> > I would prefer to have this set throughout the whole runtime of the
> > script. Otherwise we likely see a followup patch. So, either as an
> > export at the beginning of this file or as part of the command that
> > calls this script.
> 
> 
> I prefer to keep it close to the locale-dependent code.
> 
> 
> 
> If I move it to somewhere else, I need to add a comment like
> 
> # make "sort" command deterministic
> export LANG=C
> 
> Otherwise, people would have no idea why it is needed.

A comment is fine, it documents why it is here and it keeps anyone from
having to remember to add it to anything else that changes in here.

thanks,

greg k-h
