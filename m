Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C15CC432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 15:07:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C5882089D
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 15:07:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Mo6CzTW3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729441AbfKTPHk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 10:07:40 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:31580 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728030AbfKTPHj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 10:07:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574262458;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9mhlvpaevhlG/5y6GuqN9bS1rMLU0c/6HqFumE5j+Es=;
        b=Mo6CzTW3qrm9/NdhL5FdZrVAj9iQVVSQoGzMiJ+2dBo7wjQ6FYM7f/5oq5M2cgkj4TnNMD
        VuI4iEvXHu49WnW2T1TcViSGi8B54UNE1NzbUNGy3ZRYcCBD5d+bUWCNSYu6o8MRDhKu42
        GfFyOdXKqqhBoqQzhOAaQJf8rw7Dku0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-382-qwp59n4GMCS2lIwnU8GqPQ-1; Wed, 20 Nov 2019 10:07:36 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0F0AD1900DD9;
        Wed, 20 Nov 2019 15:07:35 +0000 (UTC)
Received: from krava (unknown [10.40.205.57])
        by smtp.corp.redhat.com (Postfix) with SMTP id DE4A06BF79;
        Wed, 20 Nov 2019 15:07:33 +0000 (UTC)
Date:   Wed, 20 Nov 2019 16:07:32 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Andi Kleen <andi@firstfloor.org>
Cc:     acme@kernel.org, jolsa@kernel.org, linux-kernel@vger.kernel.org,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH v7 09/12] perf stat: Use affinity for opening events
Message-ID: <20191120150732.GE4007@krava>
References: <20191116055229.62002-1-andi@firstfloor.org>
 <20191116055229.62002-10-andi@firstfloor.org>
MIME-Version: 1.0
In-Reply-To: <20191116055229.62002-10-andi@firstfloor.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: qwp59n4GMCS2lIwnU8GqPQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 15, 2019 at 09:52:26PM -0800, Andi Kleen wrote:

SNIP

> +=09if (second_pass) {
> +=09=09/*
> +=09=09 * Now redo all the weak group after closing them,
> +=09=09 * and also close errored counters.
> +=09=09 */
> +
> +=09=09evlist__for_each_cpu (evsel_list, i, cpu) {
> +=09=09=09affinity__set(&affinity, cpu);
> +=09=09=09/* First close errored or weak retry */
> +=09=09=09evlist__for_each_entry(evsel_list, counter) {
> +=09=09=09=09if (!counter->reset_group && !counter->errored)
> +=09=09=09=09=09continue;
> +=09=09=09=09if (evsel__cpu_iter_skip_no_inc(counter, cpu))
> +=09=09=09=09=09continue;
> +=09=09=09=09perf_evsel__close_cpu(&counter->core, counter->cpu_iter);
> +=09=09=09}
> +=09=09=09/* Now reopen weak */
> +=09=09=09evlist__for_each_entry(evsel_list, counter) {
> +=09=09=09=09if (!counter->reset_group && !counter->errored)
> +=09=09=09=09=09continue;
> +=09=09=09=09if (evsel__cpu_iter_skip(counter, cpu))
> +=09=09=09=09=09continue;

why staring at this I wonder why can't we call perf_evsel__close_cpu in
here and remove the above loop? together with evsel__cpu_iter_skip_no_inc
function

jirka


> +=09=09=09=09if (!counter->reset_group)
> +=09=09=09=09=09continue;
> +try_again_reset:
> +=09=09=09=09pr_debug2("reopening weak %s\n", perf_evsel__name(counter));
> +=09=09=09=09if (create_perf_stat_counter(counter, &stat_config, &target,
> +=09=09=09=09=09=09=09     counter->cpu_iter - 1) < 0) {
> +
> +=09=09=09=09=09switch (stat_handle_error(counter)) {
> +=09=09=09=09=09case COUNTER_FATAL:
> +=09=09=09=09=09=09return -1;
> +=09=09=09=09=09case COUNTER_RETRY:
> +=09=09=09=09=09=09goto try_again_reset;
> +=09=09=09=09=09case COUNTER_SKIP:
> +=09=09=09=09=09=09continue;
> +=09=09=09=09=09default:
> +=09=09=09=09=09=09break;
> +=09=09=09=09=09}
> +=09=09=09=09}
> +=09=09=09=09counter->supported =3D true;
>  =09=09=09}
>  =09=09}
> -=09=09counter->supported =3D true;
> +=09}

SNIP

