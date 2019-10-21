Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCBFDC47E49
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 16:08:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB2B9214AE
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 16:08:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HUr20xIf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729903AbfJUQIN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 12:08:13 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:43139 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729898AbfJUQIN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 12:08:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1571674092;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=h71BSZgWjjdDjQ1MEJTWRTwTTbTCpZny8dlG8GWX4y0=;
        b=HUr20xIfEhnYwwYmmKO41OL1DoS19CE2n6oeRKMGaxmMQ8Rkym1kX0jdeM4WdNz7BUD9rO
        BNc1Eco1PunHqmgdas63/p+RcWltDyS3vAPgh6jiwjG7+3ysmIgr682CfB+G9ZHQxN+bSx
        zrnX3/kWaLbhUx7i8TvyaryW6cK5iTg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-39-ipEkPB1IM-uBDQEMFpPK2g-1; Mon, 21 Oct 2019 12:08:08 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 670E0100550E;
        Mon, 21 Oct 2019 16:08:06 +0000 (UTC)
Received: from krava (unknown [10.43.17.61])
        by smtp.corp.redhat.com (Postfix) with SMTP id 726E85C240;
        Mon, 21 Oct 2019 16:08:04 +0000 (UTC)
Date:   Mon, 21 Oct 2019 18:08:03 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Jin Yao <yao.jin@linux.intel.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH v2 3/5] perf report: Sort by sampled cycles percent per
 block for stdio
Message-ID: <20191021160803.GH32718@krava>
References: <20191015053350.13909-1-yao.jin@linux.intel.com>
 <20191015053350.13909-4-yao.jin@linux.intel.com>
MIME-Version: 1.0
In-Reply-To: <20191015053350.13909-4-yao.jin@linux.intel.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: ipEkPB1IM-uBDQEMFpPK2g-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 15, 2019 at 01:33:48PM +0800, Jin Yao wrote:

SNIP

> +=09=09=09cycles +=3D bi->cycles_aggr / bi->num_aggr;
> +
> +=09=09=09he_block =3D hists__add_entry_block(&bh->block_hists,
> +=09=09=09=09=09=09=09  &al, bi);
> +=09=09=09if (!he_block) {
> +=09=09=09=09block_info__put(bi);
> +=09=09=09=09return -1;
> +=09=09=09}
> +=09=09}
> +=09}
> +
> +=09if (block_cycles)
> +=09=09*block_cycles +=3D cycles;
> +
> +=09return 0;
> +}
> +
> +static int resort_cb(struct hist_entry *he, void *arg __maybe_unused)
> +{
> +=09/* Skip the calculation of column length in output_resort */
> +=09he->filtered =3D true;

that's a nasty hack ;-) together with setting it back to false just below

why do you want to skip the columns calculation? we could add those columns
to the output as well no?

jirka

> +=09return 0;
> +}
> +
> +static void hists__clear_filtered(struct hists *hists)
> +{
> +=09struct rb_node *next =3D rb_first_cached(&hists->entries);
> +=09struct hist_entry *he;
> +
> +=09while (next) {
> +=09=09he =3D rb_entry(next, struct hist_entry, rb_node);
> +=09=09he->filtered =3D false;
> +=09=09next =3D rb_next(&he->rb_node);
> +=09}
> +}

SNIP

jirka

