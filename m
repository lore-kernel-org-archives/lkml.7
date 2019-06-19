Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D40D7C31E49
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 07:16:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0E4F208CB
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 07:16:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rjbVsfxt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730982AbfFSHQG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 03:16:06 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:39212 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725946AbfFSHQG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 03:16:06 -0400
Received: by mail-pl1-f196.google.com with SMTP id b7so6817090pls.6
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2019 00:16:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :user-agent:message-id:content-transfer-encoding;
        bh=sNH3esuo89MvVnkmn0pBqZBXKoLraPEAQm1KehvPJ+A=;
        b=rjbVsfxt9ERQsJXWee+b5RBgj6pFFU/IJp7Cj3eX9eC9jBjMnzteAgKHvn/24xy9f6
         h2XDU1eS1RkeOKM2zMnm/xgaQUmlejdoNBZTTqRlo2HE5WsNSGX/D3N9d4mKF8po7WDr
         t8PwQEUIOrTHiychpBhRpTl39fhcgOxxfcUBtNFoeMWJDD4fwMLToYaB6q5FOBlceNVy
         xNlcGaULm9R1xKuigoLTcQWwDk06EpI+L6fBwkzUeMbqh2C5giP0oYmUBenJt1gM9pRD
         MvwgUIjaWr/EMSKV5b4KYssnIXwkzKRgtDKnwfA85/mCnBYmvVicnXxj/CcAyfwBFbDK
         3TmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:user-agent:message-id:content-transfer-encoding;
        bh=sNH3esuo89MvVnkmn0pBqZBXKoLraPEAQm1KehvPJ+A=;
        b=R8rdYTVWaio5JDzHiSMB8hfrhBakUDgB0i2xXTljZO61HQXL+BEi0nYm5m8OTJmG+d
         nAXPqnX6xtUUlvZIBmIeF0hrr8sLl3a08MtSvzBbiqNg3DVmVd2o6LCD3Nn7UVwLX8Ox
         MA/n+d+WWDIpCJOMd5V9vs08yZE287GvqVn1fRv8KI9rdua8UspYF2eYQ3ZnZJsYcwIh
         IAN3CLYImKrVpTFKbLAmPWM+5RxBD06lDFTKckI0Ou56KkxoP3ClB8F09qmrig0h+lt+
         6+8aMuGMB11IPYA+762J48eVpOAUmfxX4cjRBXvzgwCy/P5oBELZT6QTKEs/fZkH0uJs
         o5xQ==
X-Gm-Message-State: APjAAAX4OZgKMhd6oH3I3B8cJ9uVXdWoGqptxxGIMmpianIpsKLAfy76
        cfeCeoY4HUJQrMW872+HSvfC9vLv
X-Google-Smtp-Source: APXvYqznH/Lv//49vNUEP8+M16EK9CA4iLmPTEN5+8c+5GM5h3VHXyjcSWO57rMh5hqlHbGTuV64MA==
X-Received: by 2002:a17:902:e082:: with SMTP id cb2mr266867plb.274.1560928565577;
        Wed, 19 Jun 2019 00:16:05 -0700 (PDT)
Received: from localhost (193-116-92-108.tpgi.com.au. [193.116.92.108])
        by smtp.gmail.com with ESMTPSA id x5sm885939pjp.21.2019.06.19.00.16.03
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 19 Jun 2019 00:16:04 -0700 (PDT)
Date:   Wed, 19 Jun 2019 17:10:52 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH 4/7] powerpc/ftrace: Additionally nop out the preceding
 mflr with -mprofile-kernel
To:     Masami Hiramatsu <mhiramat@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <cover.1560868106.git.naveen.n.rao@linux.vnet.ibm.com>
        <72492bc769cd6f40a536e689fc3195570d07fd5c.1560868106.git.naveen.n.rao@linux.vnet.ibm.com>
        <877e9idum7.fsf@concordia.ellerman.id.au>
In-Reply-To: <877e9idum7.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
User-Agent: astroid/0.14.0 (https://github.com/astroidmail/astroid)
Message-Id: <1560927184.kqsg9x9bd1.astroid@bobo.none>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Ellerman's on June 19, 2019 3:14 pm:
> Hi Naveen,
>=20
> Sorry I meant to reply to this earlier .. :/
>=20
> "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> writes:
>> With -mprofile-kernel, gcc emits 'mflr r0', followed by 'bl _mcount' to
>> enable function tracing and profiling. So far, with dynamic ftrace, we
>> used to only patch out the branch to _mcount(). However, mflr is
>> executed by the branch unit that can only execute one per cycle on
>> POWER9 and shared with branches, so it would be nice to avoid it where
>> possible.
>>
>> We cannot simply nop out the mflr either. When enabling function
>> tracing, there can be a race if tracing is enabled when some thread was
>> interrupted after executing a nop'ed out mflr. In this case, the thread
>> would execute the now-patched-in branch to _mcount() without having
>> executed the preceding mflr.
>>
>> To solve this, we now enable function tracing in 2 steps: patch in the
>> mflr instruction, use synchronize_rcu_tasks() to ensure all existing
>> threads make progress, and then patch in the branch to _mcount(). We
>> override ftrace_replace_code() with a powerpc64 variant for this
>> purpose.
>=20
> According to the ISA we're not allowed to patch mflr at runtime. See the
> section on "CMODX".

According to "quasi patch class" engineering note, we can patch
anything with a preferred nop. But that's written as an optional
facility, which we don't have a feature to test for.

>=20
> I'm also not convinced the ordering between the two patches is
> guaranteed by the ISA, given that there's possibly no isync on the other
> CPU.

Will they go through a context synchronizing event?

synchronize_rcu_tasks() should ensure a thread is scheduled away, but
I'm not actually sure it guarantees CSI if it's kernel->kernel. Could
do a smp_call_function to do the isync on each CPU to be sure.

Thanks,
Nick

=
