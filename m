Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F36FC43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 20:50:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B61920657
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 20:50:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XbjG8B3U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727179AbfCFUug (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 15:50:36 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:55845 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725747AbfCFUuf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 15:50:35 -0500
Received: by mail-wm1-f66.google.com with SMTP id q187so7294950wme.5
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2019 12:50:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZJLEOsPog/CIrY5jxHmA3PBNZAKQvPaY63wWVeaCr78=;
        b=XbjG8B3UMdMo14CwI0R7gZM2BBEIav3ka3QHWKRCIlVntZSe6o1oLEN2OHIDiFKlBY
         h6bCubMJDU9RlekzmAwaDp74gfRPfBXRz38UzZYMWlguJCkUAG/hhFWhxD5NxDHoA9aW
         D0agUo4i1IzSKHjcQvnGus9FKuYw9xAI92bMBrFBFeR2O3gGecHiKVOQDefI1+1IYZXs
         zliIZtrbP8ArqXtFaxqveAVufl7EwRIdvtvYaE8REmuyJnqkWXvYLLaw1qmnVYdrfOML
         KVIDBI6oWcZG4kgiAFsSnogOSAV8Uo2sxDxg7K0ApWF8R3z8m/qdfH0MdK7ptNH+4Ve+
         BpPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZJLEOsPog/CIrY5jxHmA3PBNZAKQvPaY63wWVeaCr78=;
        b=QwA78mkE4VPt5hG3s+gh3sj4Knww+ZSH0mHYmWTeLKZVzmN36PI6o6yzUB9QOeytxV
         6NnP2CmgGbPnHkwEcTaVNjfi058Q6nlbKh4A3rgFqukpIKcAZ1a660Dbus/qqs1R6cQ7
         6wJlhwSHuCvF9L3P8ciDbG2qM7KvdkftNvrtBoyQeklPMbDOaBNgOGBM0oaGtbnRQD9W
         UWd44edTJ4CgyBn0T3FbLC1jmvg4UnKZBxERg+tIXFcvPJ1iUsA0UcZlYAsIVPaeepFj
         qBP7gee5wTTPsv7VcoLsrhc93SmIs4/72oV4ZNOqpg4lWkHh9KiU9nJV/cOY1vJfgvIv
         hJyw==
X-Gm-Message-State: APjAAAUPFaER2FNqoQnGs144MVOuNXAF3RdthyYcCBqS+aPvCLPFg7J9
        dB0mwkeYm3IpMR6HHsAIS3fCkwDDRxt/vCZoi31DUh3jyw==
X-Google-Smtp-Source: APXvYqybbzWBS81xnSwlNXEwyNoxy3K2Up1jLn3v6fJC8BI0hjp41q4IvU3jklfaBzyaGcprBe/kcHESrxFXBrtbHqY=
X-Received: by 2002:a1c:6409:: with SMTP id y9mr3745974wmb.68.1551905433124;
 Wed, 06 Mar 2019 12:50:33 -0800 (PST)
MIME-Version: 1.0
References: <20181216190639.6safwjqwdphkce67@gmail.com> <20181216194649.GA7732@pure.paranoia.local>
 <20181216195343.idnt2y5y5wjky5gu@gmail.com> <20190104013522.stng6gwauwnr6wbi@starla>
 <CAErSpo5a2oO=5byEuA5AouS=kBmj7ihw2EVYAvJcdti29Tf1HQ@mail.gmail.com> <20190305232600.GA12110@dcvr>
In-Reply-To: <20190305232600.GA12110@dcvr>
From:   Bjorn Helgaas <bhelgaas@google.com>
Date:   Wed, 6 Mar 2019 14:50:20 -0600
Message-ID: <CAErSpo6QTdABwBx-nvkmJyv7JHb95azapwLtBf++Ved7=UpMWA@mail.gmail.com>
Subject: Re: [RFC] LKML Archive in Maildir Format
To:     Eric Wong <e@80x24.org>
Cc:     Joey Pabalinas <joeypabalinas@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernelnewbies@kernelnewbies.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        Eric Biederman <ebiederm@xmission.com>,
        Jasper Spaans <j@jasper.es>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 5, 2019 at 5:26 PM Eric Wong <e@80x24.org> wrote:
> Bjorn Helgaas <bhelgaas@google.com> wrote:

> > Any pointers?  I guess there's no mutt backend that can read a
> > public-inbox archive directly?
>
> There's mutt patches to support reading over NNTP, so that
> works:
>
>         mutt -f news://$INBOX_HOST/$INBOX_NEWSGROUP

Neomutt includes NNTP support, so I tried this:

  neomutt -f news://nntp.lore.kernel.org/org.kernel.vger.linux-kernel

which worked OK but (1) I only see the most recent 1000 messages and
(2) obviously isn't reading a *local* archive.  Neomutt took about 45
seconds to start up over my wimpy ISP.

I assume I could probably have a local archive and run a local NNTP
server and point neomutt at that local server.  But I don't know how
full-archive searching would work there.

> I don't think mutt handles mboxrd 100% correctly, but it's close
> enough that you can can download the gzipped mboxrd of a search
> query and open it via "mutt -f /path/to/downloaded/mbox.gz"
>
>   curl -XPOST -OJ "$INBOX_URL/?q=$SEARCH_QUERY&x=m"

I got nothing at all with -XPOST, but this:

  curl -OJ "https://lore.kernel.org/linux-pci/?q=d:20190301..&x=m"

got me the HTML source.  Nothing that looks like mboxrd.  I assume
this is stupid user error on my part, but even with that resolved, it
wouldn't have the nice git fetch properties of the git archive, i.e.,
incremental updates of only new stuff, would it?

I think my ideal solution would be a mutt that could read the git
archive directly, plus a notmuch index.  But AFAIK, mutt can't do
that, and notmuch only works with one message per file, not with the
git archive.

Something that might work would be to use Konstantin's "git archive to
maildir" hint but shard into a bunch of smaller maildirs instead of
one big one, then have notmuch index those, and use mutt or vim with
notmuch queries instead of having it read in a maildir.

But I feel like I must be missing the solution that's obvious to
everybody but me.

Bjorn
