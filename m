Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1CE2C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 01:00:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C3282184E
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 01:00:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="NxMWxLtn";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="QIJ0sDtG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726787AbfCNBAc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 21:00:32 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:55404 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726078AbfCNBAc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 21:00:32 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 3E944608FC; Thu, 14 Mar 2019 01:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1552525230;
        bh=FmPpyrS3c26D3TZhgVmksnrSDaC+Sn9ouCUcy+WTlAg=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=NxMWxLtnFIHvyAZhjSIow+YLwAZ/TfJhETb95LqB7fgZjhIAJpBk7F0kG069eSJKc
         o92RktQYdjBjDZtf+yg7gwYV/6mZBqzJZQRzl5I/lsXfdZwe6ZTaMNAqqmuIcp6Z/c
         RwzH/x3ZHFziCReLD2O5UBBQ6x4dDsVGioGeqYVs=
Received: from [10.46.162.237] (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: daidavid1@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id BF4B560312;
        Thu, 14 Mar 2019 01:00:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1552525228;
        bh=FmPpyrS3c26D3TZhgVmksnrSDaC+Sn9ouCUcy+WTlAg=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=QIJ0sDtGGbRBZfSu6H3nT4X969le7gSzbJraqIeeyr1ge5goQxhCRTcGk3G8YJXWh
         LZaRMoNAWkVfKq8XsWxoLJjteBI4ou3RTSoytCQ0+PH8eAbD63YlVwlhSF6QHgDxCx
         xvEiytrVExAoyfgbVbYREaj6jXESYYAuBYFZBU7o=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org BF4B560312
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=daidavid1@codeaurora.org
Subject: Re: [PATCH v1 2/2] interconnect: qcom: Add tagging and wake/sleep
 support for sdm845
To:     Evan Green <evgreen@chromium.org>,
        Georgi Djakov <georgi.djakov@linaro.org>
Cc:     linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        amit.kucheria@linaro.org, Doug Anderson <dianders@chromium.org>,
        Sean Sweeney <seansw@qti.qualcomm.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Alexandre Bailon <abailon@baylibre.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        ksitaraman@nvidia.com, sanjayc@nvidia.com,
        henryc.chen@mediatek.com, LKML <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>
References: <20190208172152.1807-1-georgi.djakov@linaro.org>
 <20190208172152.1807-3-georgi.djakov@linaro.org>
 <CAE=gft47bF-zJReobnUnsVGtiMCMqz4jWZLDWdMJ5qRUL+PH7g@mail.gmail.com>
From:   David Dai <daidavid1@codeaurora.org>
Message-ID: <9b93d5e4-2f68-06ee-82b9-29ccffc961e1@codeaurora.org>
Date:   Wed, 13 Mar 2019 18:00:27 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.2
MIME-Version: 1.0
In-Reply-To: <CAE=gft47bF-zJReobnUnsVGtiMCMqz4jWZLDWdMJ5qRUL+PH7g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/8/2019 10:35 AM, Evan Green wrote:
> On Fri, Feb 8, 2019 at 9:22 AM Georgi Djakov <georgi.djakov@linaro.org> wrote:
>> From: David Dai <daidavid1@codeaurora.org>
>>
>> Add support for wake and sleep commands by using a tag to indicate
>> whether or not the aggregate and set requests are active only or
>> dual context for a particular path.
>>
>> Signed-off-by: David Dai <daidavid1@codeaurora.org>
>> Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
>> ---
>>   drivers/interconnect/qcom/sdm845.c | 101 +++++++++++++++++++++--------
>>   1 file changed, 75 insertions(+), 26 deletions(-)
>>
>> diff --git a/drivers/interconnect/qcom/sdm845.c b/drivers/interconnect/qcom/sdm845.c
>> index fb526004c82e..13499f681160 100644
>> --- a/drivers/interconnect/qcom/sdm845.c
>> +++ b/drivers/interconnect/qcom/sdm845.c
>> @@ -65,6 +65,12 @@ struct bcm_db {
>>   #define SDM845_MAX_BCMS                30
>>   #define SDM845_MAX_BCM_PER_NODE        2
>>   #define SDM845_MAX_VCD         10
>> +#define SDM845_MAX_CTX         2
>> +#define SDM845_EE_STATE                2
>> +#define EE_STATE_WAKE          0
>> +#define EE_STATE_SLEEP         1
>> +#define AO_CTX                 0
>> +#define DUAL_CTX               1
>>
> I get really lost with these two sets of numbers here. I think this
> needs some explanation in the comments. From staring at this what I've
> understood so far is:
> 1) Clients pass in a tag that buckets their requests into either AO or
> DUAL within the node. (Although, the requests all seem to get
> aggregated together no matter what the tag is, more on that later).
> 2) During icc_set(), we go through the many-to-many mapping of BCMs to
> nodes. For each BCM, we aggregate all the nodes it has, bucketed again
> by AO or DUAL.
> 3) The actual votes sent to RPMh are in terms of WAKE and SLEEP.
> 4) The mapping from AO/DUAL to WAKE/SLEEP for a particular BCM is:
> WAKE = AO+DUAL, SLEEP=DUAL.
> 5) qcom_icc_set() sends EE_STATE_WAKE stuff to RPMH_ACTIVE_ONLY_STATE.
> 6) If there's any difference between SLEEP and WAKE, then the
> EE_STATE_WAKE commands are gathered together and sent to
> RPMH_WAKE_ONLY_STATE, and all the EE_STATE_SLEEP commands are sent to
> RPMH_SLEEP_STATE.
>
> So ultimately the muxing ends up like
> RPMH_ACTIVE_ONLY_STATE <-- EE_STATE_WAKE <-- AO+DUAL
> RPMH_SLEEP_STATE <-- EE_STATE_SLEEP <-- DUAL
> RPMH_WAKE_ONLY_STATE <-- EE_STATE_WAKE <-- AO+DUAL
This muxing explanation is correct, there's also an inherent limitation 
in this muxing where RPMH_ACTIVE cannot differ from RPMH_WAKE.
>
> Why do we need this complicated muxing to happen? Is it because we're
> trying to avoid requiring drivers to specify three different paths in
> the simple case, when all they care about is "use this bandwidth all
> the time"?
That's a part of it, I don't have strong justification for this legacy 
way of supporting wake/sleep, so I'm open to new suggestions.
> What I think would make more sense would be to use the "tag" as a
> bitfield instead. So you'd have
>
> #define QCOM_ICC_TAG_ACTIVE_ONLY 0x00000001
> #define QCOM_ICC_TAG_SLEEP 0x00000002
> #define QCOM_ICC_TAG_WAKE 0x00000004
> #define QCOM_ICC_TAG_ALL_TIMES (QCOM_ICC_TAG_ACTIVE_ONLY |
> QCOM_ICC_TAG_SLEEP | QCOM_ICC_TAG_WAKE)
>
> Drivers that don't care about sleep/wake sets would just not set a
> tag, or set a tag of QCOM_ICC_TAG_ALL_TIMES. Then in
> qcom_icc_aggregate(), you aggregate the same values up to three times,
> one for each bit they have set. Finally in qcom_icc_set, you can pass
> the votes directly down in their buckets, without doing a weird
> mapping from AO/DUAL to SLEEP/WAKE/ACTIVE_ONLY.
Works for me, I'd still want to optimize out the WAKE/SLEEP commands 
that are equal to each other though.
> The sticky part about this is that now rather than one set of sum/peak
> values, there are now three independent ones, corresponding to each of
> the tag bits. It seems like the interconnect core wouldn't want to
> mandate whether providers use the tag as a bitfield or a value. So the
> provider would need to keep not only the official set of aggregates
> that are returned back to the core (probably ACTIVE_ONLY, or maybe a
> max of the three), but also the two shadow copies internally for SLEEP
> and WAKE.
I would ideally like to return the most accurate current state of the 
system which may be ACTIVE_ONLY or WAKE. We might also run into some 
confusion when printing out the summaries for each node. In a case where 
the votes for WAKE != ACTIVE(assuming one or more multiple consumers are 
intentionally doing this with multiple paths), the state of system will 
change depending on whether or not we've completed a sleep cycle(If it's 
prior to sleep, the ACTIVE_ONLY vote will be accurate, and post waking 
up the WAKE request will be correct) but this is more of a book keeping 
concern than anything else, as long as consumers understand that this is 
the expected behavior. On a side note, I don't like the ACTIVE_ONLY name 
designation for this which was brought over from the rpmh driver, it 
really means let's set the current state immediately and it has no 
association with the execution environment state unlike the other 
WAKE/SLEEP types.
>
> If you organized the tag that way, the only extra thing you'd need is
> a callback to the provider just before the core starts aggregation, so
> that the provider can reset the shadow buckets to 0 the same way the
> core resets the main sum/peak to 0 before looping.With this, we've
> plumbed out the full abilities of RPMh to the client drivers, but
> without complicating the simple case of "set this bandwidth all the
> time". What do you think?

I really like this idea for the most part, it certainly simplifies some 
of the muxing that happens underneath the layer and makes the 
aggregation to the RPMH driver a lot more transparent. Though we should 
probably just reset the shadow buckets to 0 at the end of a call into 
provider icc_set as part of cleaning up the state after we've committed 
some requests into hardware? I don't see a need to have to add another 
call back into the provider before aggregation.

>
>>   /**
>>    * struct qcom_icc_node - Qualcomm specific interconnect nodes
>> @@ -86,8 +92,8 @@ struct qcom_icc_node {
>>          u16 num_links;
>>          u16 channels;
>>          u16 buswidth;
>> -       u64 sum_avg;
>> -       u64 max_peak;
>> +       u64 sum_avg[SDM845_MAX_CTX];
>> +       u64 max_peak[SDM845_MAX_CTX];
>>          struct qcom_icc_bcm *bcms[SDM845_MAX_BCM_PER_NODE];
>>          size_t num_bcms;
>>   };
>> @@ -112,8 +118,8 @@ struct qcom_icc_bcm {
>>          const char *name;
>>          u32 type;
>>          u32 addr;
>> -       u64 vote_x;
>> -       u64 vote_y;
>> +       u64 vote_x[SDM845_EE_STATE];
>> +       u64 vote_y[SDM845_EE_STATE];
>>          bool dirty;
>>          bool keepalive;
>>          struct bcm_db aux_data;
>> @@ -555,7 +561,7 @@ inline void tcs_cmd_gen(struct tcs_cmd *cmd, u64 vote_x, u64 vote_y,
>>                  cmd->wait = true;
>>   }
>>
>> -static void tcs_list_gen(struct list_head *bcm_list,
>> +static void tcs_list_gen(struct list_head *bcm_list, int ee_state,
>>                           struct tcs_cmd tcs_list[SDM845_MAX_VCD],
>>                           int n[SDM845_MAX_VCD])
>>   {
>> @@ -573,8 +579,8 @@ static void tcs_list_gen(struct list_head *bcm_list,
>>                          commit = true;
>>                          cur_vcd_size = 0;
>>                  }
>> -               tcs_cmd_gen(&tcs_list[idx], bcm->vote_x, bcm->vote_y,
>> -                           bcm->addr, commit);
>> +               tcs_cmd_gen(&tcs_list[idx], bcm->vote_x[ee_state],
>> +                           bcm->vote_y[ee_state], bcm->addr, commit);
>>                  idx++;
>>                  n[batch]++;
>>                  /*
>> @@ -595,32 +601,42 @@ static void tcs_list_gen(struct list_head *bcm_list,
>>
>>   static void bcm_aggregate(struct qcom_icc_bcm *bcm)
>>   {
>> -       size_t i;
>> -       u64 agg_avg = 0;
>> -       u64 agg_peak = 0;
>> +       size_t i, ctx;
>> +       u64 agg_avg[SDM845_MAX_CTX] = {0};
>> +       u64 agg_peak[SDM845_MAX_CTX] = {0};
>>          u64 temp;
>>
>> -       for (i = 0; i < bcm->num_nodes; i++) {
>> -               temp = bcm->nodes[i]->sum_avg * bcm->aux_data.width;
>> -               do_div(temp, bcm->nodes[i]->buswidth * bcm->nodes[i]->channels);
>> -               agg_avg = max(agg_avg, temp);
>> +       for (ctx = 0; ctx < SDM845_MAX_CTX; ctx++) {
>> +               for (i = 0; i < bcm->num_nodes; i++) {
>> +                       temp = bcm->nodes[i]->sum_avg[ctx] * bcm->aux_data.width;
>> +                       do_div(temp, bcm->nodes[i]->buswidth * bcm->nodes[i]->channels);
>> +                       agg_avg[ctx] = max(agg_avg[ctx], temp);
>>
>> -               temp = bcm->nodes[i]->max_peak * bcm->aux_data.width;
>> -               do_div(temp, bcm->nodes[i]->buswidth);
>> -               agg_peak = max(agg_peak, temp);
>> +                       temp = bcm->nodes[i]->max_peak[ctx] * bcm->aux_data.width;
>> +                       do_div(temp, bcm->nodes[i]->buswidth);
>> +                       agg_peak[ctx] = max(agg_peak[ctx], temp);
>> +               }
>>          }
>>
>> -       temp = agg_avg * 1000ULL;
>> +       temp = agg_avg[AO_CTX] + agg_avg[DUAL_CTX] * 1000ULL;
>> +       do_div(temp, bcm->aux_data.unit);
>> +       bcm->vote_x[EE_STATE_WAKE] = temp;
>> +
>> +       temp = max(agg_peak[AO_CTX], agg_peak[DUAL_CTX]) * 1000ULL;
>> +       do_div(temp, bcm->aux_data.unit);
>> +       bcm->vote_y[EE_STATE_WAKE] = temp;
>> +
>> +       temp = agg_avg[DUAL_CTX] * 1000ULL;
>>          do_div(temp, bcm->aux_data.unit);
>> -       bcm->vote_x = temp;
>> +       bcm->vote_x[EE_STATE_SLEEP] = temp;
>>
>> -       temp = agg_peak * 1000ULL;
>> +       temp = agg_peak[DUAL_CTX] * 1000ULL;
>>          do_div(temp, bcm->aux_data.unit);
>> -       bcm->vote_y = temp;
>> +       bcm->vote_y[EE_STATE_SLEEP] = temp;
>>
>>          if (bcm->keepalive && bcm->vote_x == 0 && bcm->vote_y == 0) {
>> -               bcm->vote_x = 1;
>> -               bcm->vote_y = 1;
>> +               bcm->vote_x[EE_STATE_WAKE] = 1;
>> +               bcm->vote_y[EE_STATE_WAKE] = 1;
>>          }
>>
>>          bcm->dirty = false;
>> @@ -631,14 +647,16 @@ static int qcom_icc_aggregate(struct icc_node *node, u32 tag, u32 avg_bw,
>>   {
>>          size_t i;
>>          struct qcom_icc_node *qn;
>> +       u32 ctx = 0;
>>
>>          qn = node->data;
>> +       ctx = (!!tag) ? AO_CTX : DUAL_CTX;
>>
>>          *agg_avg += avg_bw;
>>          *agg_peak = max_t(u32, *agg_peak, peak_bw);
>>
>> -       qn->sum_avg = *agg_avg;
>> -       qn->max_peak = *agg_peak;
>> +       qn->sum_avg[ctx] = *agg_avg;
>> +       qn->max_peak[ctx] = *agg_peak;
> I'm confused that you seem to aggregate agg_avg and agg_peak
> regardless of what the tag is, but then save them into buckets as if
> they had been kept separate. Doesn't this just end up as a mish-mash
> of all tag aggregates, but whose final value is dependent on the order
> of requests? (Said another way, what gets saved into each [ctx] bucket
> is the the aggregate of all requests regardless of tag, but only up
> until the last request of that tag type was seen.)
This was a mistake, the buckets should only aggregate among themselves, 
which also needs to cleaned up before the next set of aggregations.

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

