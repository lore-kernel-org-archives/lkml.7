Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AE39CA9EAE
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 13:35:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6F0320874
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 13:35:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WkF84yvG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388694AbfJ2Nfd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 09:35:33 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:43871 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2388667AbfJ2Nfc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 09:35:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1572356131;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Giq8Yqxk7smLdQbVdrNtJ7/JmLLVzAyYYDX0cuxJ2Ug=;
        b=WkF84yvGv2VMyq43DEM8Y/OEbFp912Zylzr22Kt8gkWM8F+kAoNVsU/V2md0ufSf8kSwZr
        ybmeMZbMAxFbcLgAqF2KDz7jAezw5zw/KsaT9Ape8g3jy5zdLYJn8VEzCxQABRzWLpzwfA
        CT4l/G0PPpZb3EKH/pSpUisqR+wqQ5o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-345-l-2D2QCPMQi-34ti9oYutA-1; Tue, 29 Oct 2019 09:35:30 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4026E107AD28;
        Tue, 29 Oct 2019 13:35:29 +0000 (UTC)
Received: from treble (ovpn-121-225.rdu2.redhat.com [10.10.121.225])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id AFE2060C4E;
        Tue, 29 Oct 2019 13:35:28 +0000 (UTC)
Date:   Tue, 29 Oct 2019 08:35:26 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Jiri Slaby <jslaby@suse.cz>
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] stacktrace: don't skip first entry on noncurrent tasks
Message-ID: <20191029133526.tqzo4axnuyozaqzc@treble>
References: <20191025142110.jgz5jy4nuryhawv5@treble>
 <20191029071944.17123-1-jslaby@suse.cz>
MIME-Version: 1.0
In-Reply-To: <20191029071944.17123-1-jslaby@suse.cz>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: l-2D2QCPMQi-34ti9oYutA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 29, 2019 at 08:19:44AM +0100, Jiri Slaby wrote:
> When doing cat /proc/<PID>/stack, the output is missing the first entry.
> When the current code walks the stack starting in stack_trace_save_tsk,
> it skips all scheduler functions (that's OK) plus one more function. But
> this one function should be skipped only for the 'current' task as it is
> stack_trace_save_tsk proper.
>=20
> The original code (before the common infrastructure) skipped one
> function only for the 'current' task -- see save_stack_trace_tsk before
> 3599fe12a125. So do so also in the new infrastructure now.
>=20
> Signed-off-by: Jiri Slaby <jslaby@suse.cz>
> Fixes: 214d8ca6ee85 ("stacktrace: Provide common infrastructure")
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Josh Poimboeuf <jpoimboe@redhat.com>
> ---
>=20
> Notes:
>     [v2] add the same for the !CONFIG_ARCH_STACKWALK case

Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>

--=20
Josh

