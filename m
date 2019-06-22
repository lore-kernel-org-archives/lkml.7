Return-Path: <SRS0=kYop=UV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 434E2C43613
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 17:54:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20B1520665
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 17:54:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726437AbfFVRyu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Jun 2019 13:54:50 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:33369 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726299AbfFVRyu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jun 2019 13:54:50 -0400
Received: by mail-io1-f68.google.com with SMTP id u13so313623iop.0
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jun 2019 10:54:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=6dq/P/oYxkiMxIGaVnr0C8AyZeCqmInR54AoEj7GHlw=;
        b=ubvS5qCBaBNK6Y56OAqSKLsMi4yU+vej1cwKSlDXK/C1xUQZ196ui1I/MJQ6jD5huh
         Qdl08CCyMIV3m/lyz+0Vp+hZAoN/BdcWxYttbQacSwpnKsDVGA3/xEwwD8AUnoFg3iSx
         /qWnLstlse4V6KhoWj+UaIDYaW2lVNp+bfKCoBttTc/ABAICevOq6glVPcz1UAk7vIJD
         zOZ7AiWVKhr93+n0i0dyS3UMVZt+D9nJJnZWB8Hzzbe1TzamvIGoBw2SAIqMZxinvoEp
         o4CfVRgozvvcg4FIyZR9Gi2+nY2THBZuUWv1Oy/EgS1yRkPKuVpW03XI2qchDiKWZphQ
         oQ9w==
X-Gm-Message-State: APjAAAUv6NI18QpAD2aEav84rz0b5z25FdnpSwMQ8z0yI955u80OzD2i
        anNKo/nGUGIch0pPEoxm9i2rfHKIiKqBUai6hY88/yOc
X-Google-Smtp-Source: APXvYqwfmzYepjt1UbzLYFgHLWIfcJCq+inBEB6bo0prCEsx2fgq7+ahunjMK+n9xsBA7YDAJUXByReW7I6jXX83kdc=
X-Received: by 2002:a5d:9dc7:: with SMTP id 7mr32293713ioo.237.1561226089232;
 Sat, 22 Jun 2019 10:54:49 -0700 (PDT)
MIME-Version: 1.0
References: <CA+hQ2+j-8HoWK_fpJkvKRv22WMLEU_6ym0--tSz-jEMN+NPtcg@mail.gmail.com>
In-Reply-To: <CA+hQ2+j-8HoWK_fpJkvKRv22WMLEU_6ym0--tSz-jEMN+NPtcg@mail.gmail.com>
From:   Luigi Rizzo <rizzo@iet.unipi.it>
Date:   Sat, 22 Jun 2019 10:54:36 -0700
Message-ID: <CA+hQ2+hMjpifq4ef1u4pfvXvgjCp4G7qMSE=GciHarVGrXC3pg@mail.gmail.com>
Subject: Q: incorrect llist_empty() call in flush_smp_call_function_queue ?
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

flush_smp_call_function_queue() starts with the code below.
My impression is that the !llist_empty(head) term below is wrong
and should be replaced by !entry

llist_del_all(head) is  xchg(&head->first, NULL) so it leaves the list empty,
the only chance that !llist_empty(head) is true is when a new element is
added between llist_del_add and the test of the condition, whereas judging
from the comment the intent seems to be that the warning should be printed
also when there are previous elements.

static void flush_smp_call_function_queue(bool warn_cpu_offline)
{
        ...
        head = this_cpu_ptr(&call_single_queue);
        entry = llist_del_all(head);
        entry = llist_reverse_order(entry);

        /* There shouldn't be any pending callbacks on an offline CPU. */
        if (unlikely(warn_cpu_offline && !cpu_online(smp_processor_id()) &&
                     !warned && !llist_empty(head))) {
                warned = true;
                WARN(1, "IPI on offline CPU %d\n", smp_processor_id());

--

cheers
luigi
