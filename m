Return-Path: <SRS0=G0tX=VI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DE5FC742A2
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 20:50:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8091208E4
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 20:50:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="OH1nH1Jx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728687AbfGKUuk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jul 2019 16:50:40 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:35339 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728538AbfGKUuk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jul 2019 16:50:40 -0400
Received: by mail-lj1-f196.google.com with SMTP id x25so7201378ljh.2
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2019 13:50:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dYjxp66wgB3t394QorK0WPrW2jXGX2qG/znE9bxRn1o=;
        b=OH1nH1JxcyIJ1Frv7bR1psVD2AkOX68Z06jMu6w+iKf4koMKEnVt0JThRnXKzImvV7
         J3Z3Nl/H5FA/erTmCGF/qw3sMCLW0JXQR/CgOLxF+xN3iTuTAPf+3vmVJxb5wDaonHmn
         N5opQfDUhQroiwNBX3un98PdvECR62kpygl3U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dYjxp66wgB3t394QorK0WPrW2jXGX2qG/znE9bxRn1o=;
        b=RgCGdQU7QoVMK8Ct0is3R+aQeitr1RzfTwcZjruLwffJMco1F79/mOreLymqyhtWn3
         o+r6+9qPuJZYn11c0HoIksuUGontfUclyPXXObrJxGkhoyMD7p4+sHWttaDXRC1NsjVv
         pw8VseRnc4uiA523yEyMeoUuo/+I9bfWsrm4nGJ+p6mp2/UefBc5RwK1mvXPl211vIgl
         xRNu6n8rZvZmLFmVMJdsnxvD3cf4bKIST2c8qxCr+byb3PdXSPH5nJaHegFFhCXo7n6x
         Z/seqrklC4+zYP21JLiHJ/l0Lp1DgTa1/OaO45JLBjz8lnhsgB0AdcwEIvM81z+zoUxx
         /DIg==
X-Gm-Message-State: APjAAAWLfwkNc+pswDTxSvPliYasNRY7EModphpQMXkS2ZszdX7GqLVJ
        3cwD0s+/pymYbbtFX773kVQEUdvWljlqttMPlSEGQ07i
X-Google-Smtp-Source: APXvYqyTowl8LDpO3glgWe4q53UddCDACSqIkn83mbNwYk66wIQHKoZZ8RculjXa8Wt7mSwwCQxgYNfcJFE9RnOFrVI=
X-Received: by 2002:a2e:9147:: with SMTP id q7mr3641900ljg.19.1562878238030;
 Thu, 11 Jul 2019 13:50:38 -0700 (PDT)
MIME-Version: 1.0
References: <20190711204541.28940-1-joel@joelfernandes.org>
In-Reply-To: <20190711204541.28940-1-joel@joelfernandes.org>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Thu, 11 Jul 2019 16:50:26 -0400
Message-ID: <CAEXW_YS=Sb6k4_Z-fXdtERTHZDO_PHQCOhx6bhotWduCB7K28w@mail.gmail.com>
Subject: Re: [PATCH] treewide: Rename rcu_dereference_raw_notrace to _check
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Ingo Molnar <mingo@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Josh Triplett <josh@joshtriplett.org>, kvm-ppc@vger.kernel.org,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        PowerPC <linuxppc-dev@lists.ozlabs.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Paul Mackerras <paulus@ozlabs.org>, rcu <rcu@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Byungchul Park <byungchul.park@lge.com>,
        kernel-team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 11, 2019 at 4:45 PM Joel Fernandes (Google)
<joel@joelfernandes.org> wrote:
>
> The rcu_dereference_raw_notrace() API name is confusing.
> It is equivalent to rcu_dereference_raw() except that it also does
> sparse pointer checking.
>
> There are only a few users of rcu_dereference_raw_notrace(). This
> patches renames all of them to be rcu_dereference_raw_check with the
> "check" indicating sparse checking.
>
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>

There also these _notrace things but I am Ok with leaving them alone for now:
hash_for_each_possible_rcu_notrace
hlist_for_each_entry_rcu_notrace

- Joel
