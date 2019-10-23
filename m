Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEB96CA9EB6
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 12:42:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A46FE21906
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 12:42:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="DQf113s2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391619AbfJWMmo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 08:42:44 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:39939 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732361AbfJWMmo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 08:42:44 -0400
Received: by mail-qk1-f194.google.com with SMTP id y81so15684090qkb.7
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2019 05:42:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=mKyOrNdcShBVuby78giN6WHF0/2rdo1R9G5aayTHBy4=;
        b=DQf113s2Ove9W20kNFDkOTSoIFdDb3YWXnkZWNQ87u6IGupJcMQbUlbei0LZXxZQs/
         TqpXedoG0Czy54pJzsg6c0oIBRDYsRS5dWGPDslcttanQD3uNlsKuiBl6G92fUXi+jXA
         NY8AYQdI6IeuI0f8EKfDfvytMOLr8a2f/JHG5wYJhXEAptTMOLr+mpljwKjUj/Napzq1
         96agON74xwbA/UQWQUx7ktbirN503MLZuUDG19lI1UZyOrsLXJ8qb9ogaJJ8wxlOLXt5
         Qqql8yuW4FkEMeIJwKoBx9JwiJI6UCKohvK4E3WZGkchw1m4oy2DtwDVa3MCF2y+Ya4Q
         vEnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=mKyOrNdcShBVuby78giN6WHF0/2rdo1R9G5aayTHBy4=;
        b=A+qYF+K8FjvivvH9xV+hFL4RTR2qhVtMpMVupLA/Ns3UmF5h/hUZJMmWgCOjYMaRWO
         1pjUjkBqwTRVO2TXlacWaexwsu1bBsx7t0gWiUyZR6QRFRXr1SlUqFpn6P46V0Nc+lzU
         2m3mMSChyjNo+hl1XGNO8DpqujCuJiYTbzCTrpRTdkzVxu3KfgqWE13ULbTChq6FBAvz
         HSs+tAGmjKe6sTMiDtesJW7dk0Sl77ryrQ/Ngy5/RNeeM56rUoYylzhaIuzEtmg0DdoC
         zCk4OxWLcZC1yA4ywBTOQPFqEiCbx8Eke8jMe6XTCtetB0hoL3DonNzq8gReH5rwGdaQ
         B5Ng==
X-Gm-Message-State: APjAAAVZSRMfvuxoSatWVX/oTYKqQYRbf0GIr6WHtZ6LYTfw9gUgpbLk
        HFS+4iEFZpuk+6nK0Xgb41tAjg==
X-Google-Smtp-Source: APXvYqzAxLS8JhAkJl2sEI6TpG9FWohKN2MaJ4mlvx91OUAfECuSmhyAf03NCVSZfUDDKb6ogR7tRw==
X-Received: by 2002:a37:a8d3:: with SMTP id r202mr7705859qke.405.1571834561570;
        Wed, 23 Oct 2019 05:42:41 -0700 (PDT)
Received: from [192.168.1.183] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id j7sm17172579qtc.73.2019.10.23.05.42.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Oct 2019 05:42:40 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
From:   Qian Cai <cai@lca.pw>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] mm/vmstat: Reduce zone lock hold time when reading /proc/pagetypeinfo
Date:   Wed, 23 Oct 2019 08:42:40 -0400
Message-Id: <C448FBC6-60AE-46FA-9548-FF31A22378BC@lca.pw>
References: <20191023095607.GE3016@techsingularity.net>
Cc:     Michal Hocko <mhocko@kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Waiman Long <longman@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <guro@fb.com>, Vlastimil Babka <vbabka@suse.cz>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Jann Horn <jannh@google.com>, Song Liu <songliubraving@fb.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rafael Aquini <aquini@redhat.com>
In-Reply-To: <20191023095607.GE3016@techsingularity.net>
To:     Mel Gorman <mgorman@suse.de>
X-Mailer: iPhone Mail (17A878)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Oct 23, 2019, at 5:56 AM, Mel Gorman <mgorman@suse.de> wrote:
>=20
> Again, the cost is when reading a proc file. =46rom what Andrew said,
> the lock is necessary to safely walk the list but if anything. I would
> be ok with limiting the length of the walk but honestly, I would also
> be ok with simply deleting the proc file. The utility for debugging a
> problem with it is limited now (it was more important when fragmentation
> avoidance was first introduced) and there is little an admin can do with
> the information. I can't remember the last time I asked for the contents
> of the file when trying to debug a problem. There is a possibility that
> someone will complain but I'm not aware of any utility that reads the
> information and does something useful with it. In the unlikely event
> something breaks, the file can be re-added with a limited walk.

Agree. It is better to remove this file all together in linux-next first for=
 a while to see if anyone complains loudly.=
