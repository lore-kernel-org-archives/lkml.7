Return-Path: <SRS0=QHyQ=ZU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4919BC432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 13:34:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19EF621741
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 13:34:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726694AbfK1Nec (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Nov 2019 08:34:32 -0500
Received: from mga17.intel.com ([192.55.52.151]:56394 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726227AbfK1Neb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Nov 2019 08:34:31 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Nov 2019 05:34:27 -0800
X-IronPort-AV: E=Sophos;i="5.69,253,1571727600"; 
   d="scan'208";a="199529160"
Received: from jnikula-mobl3.fi.intel.com (HELO localhost) ([10.237.66.161])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Nov 2019 05:34:24 -0800
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Benjamin GAIGNARD <benjamin.gaignard@st.com>,
        "maarten.lankhorst\@linux.intel.com" 
        <maarten.lankhorst@linux.intel.com>,
        "mripard\@kernel.org" <mripard@kernel.org>,
        "sean\@poorly.run" <sean@poorly.run>,
        "airlied\@linux.ie" <airlied@linux.ie>,
        "daniel\@ffwll.ch" <daniel@ffwll.ch>
Cc:     "dri-devel\@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] drm/dp_mst: Fix W=1 warnings
In-Reply-To: <8f64b1e7-d7b8-43df-8efe-ca5af91e2cd3@st.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20191128110012.23898-1-benjamin.gaignard@st.com> <87sgm8mekf.fsf@intel.com> <8f64b1e7-d7b8-43df-8efe-ca5af91e2cd3@st.com>
Date:   Thu, 28 Nov 2019 15:34:21 +0200
Message-ID: <87h82om8f6.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Nov 2019, Benjamin GAIGNARD <benjamin.gaignard@st.com> wrote:
> On 11/28/19 12:21 PM, Jani Nikula wrote:
>> On Thu, 28 Nov 2019, Benjamin Gaignard <benjamin.gaignard@st.com> wrote:
>>> Fix the warnings that show up with W=1.
>>> They are all about unused but set variables.
>>> If functions returns are not used anymore make them void.
>>>
>>> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
>>> CC: Jani Nikula <jani.nikula@linux.intel.com>
>>> ---
>>> changes in version 2:
>>> - fix indentations
>>> - when possible change functions prototype to void
>>>
>>> Note: this patch may conflict with c485e2c97dae ("drm/dp_mst: Refactor pdt
>>> setup/teardown, add more locking") when it will hit drm-misc-next
>> Well, why create an unnecessary conflict when the referenced commit also
>> fixes the same warnings as a side-effect?
>
> Because this commit is not merged (yet ?) in drm-misc-next which where I 
> start.

I mean just leave the hunk out and the problem will fix itself once the
stuff gets backmerged to drm-misc-next.

BR,
Jani.


>
> Benjamin
>
>> BR,
>> Jani.
>>
>>
>>>   drivers/gpu/drm/drm_dp_mst_topology.c | 83 +++++++++++++----------------------
>>>   1 file changed, 31 insertions(+), 52 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/drm_dp_mst_topology.c b/drivers/gpu/drm/drm_dp_mst_topology.c
>>> index b854a422a523..ff2d81db0778 100644
>>> --- a/drivers/gpu/drm/drm_dp_mst_topology.c
>>> +++ b/drivers/gpu/drm/drm_dp_mst_topology.c
>>> @@ -672,7 +672,6 @@ static bool drm_dp_sideband_msg_build(struct drm_dp_sideband_msg_rx *msg,
>>>   				      u8 *replybuf, u8 replybuflen, bool hdr)
>>>   {
>>>   	int ret;
>>> -	u8 crc4;
>>>   
>>>   	if (hdr) {
>>>   		u8 hdrlen;
>>> @@ -714,8 +713,6 @@ static bool drm_dp_sideband_msg_build(struct drm_dp_sideband_msg_rx *msg,
>>>   	}
>>>   
>>>   	if (msg->curchunk_idx >= msg->curchunk_len) {
>>> -		/* do CRC */
>>> -		crc4 = drm_dp_msg_data_crc4(msg->chunk, msg->curchunk_len - 1);
>>>   		/* copy chunk into bigger msg */
>>>   		memcpy(&msg->msg[msg->curlen], msg->chunk, msg->curchunk_len - 1);
>>>   		msg->curlen += msg->curchunk_len - 1;
>>> @@ -1012,7 +1009,7 @@ static bool drm_dp_sideband_parse_req(struct drm_dp_sideband_msg_rx *raw,
>>>   	}
>>>   }
>>>   
>>> -static int build_dpcd_write(struct drm_dp_sideband_msg_tx *msg, u8 port_num, u32 offset, u8 num_bytes, u8 *bytes)
>>> +static void build_dpcd_write(struct drm_dp_sideband_msg_tx *msg, u8 port_num, u32 offset, u8 num_bytes, u8 *bytes)
>>>   {
>>>   	struct drm_dp_sideband_msg_req_body req;
>>>   
>>> @@ -1022,17 +1019,14 @@ static int build_dpcd_write(struct drm_dp_sideband_msg_tx *msg, u8 port_num, u32
>>>   	req.u.dpcd_write.num_bytes = num_bytes;
>>>   	req.u.dpcd_write.bytes = bytes;
>>>   	drm_dp_encode_sideband_req(&req, msg);
>>> -
>>> -	return 0;
>>>   }
>>>   
>>> -static int build_link_address(struct drm_dp_sideband_msg_tx *msg)
>>> +static void build_link_address(struct drm_dp_sideband_msg_tx *msg)
>>>   {
>>>   	struct drm_dp_sideband_msg_req_body req;
>>>   
>>>   	req.req_type = DP_LINK_ADDRESS;
>>>   	drm_dp_encode_sideband_req(&req, msg);
>>> -	return 0;
>>>   }
>>>   
>>>   static int build_enum_path_resources(struct drm_dp_sideband_msg_tx *msg, int port_num)
>>> @@ -1046,7 +1040,7 @@ static int build_enum_path_resources(struct drm_dp_sideband_msg_tx *msg, int por
>>>   	return 0;
>>>   }
>>>   
>>> -static int build_allocate_payload(struct drm_dp_sideband_msg_tx *msg, int port_num,
>>> +static void build_allocate_payload(struct drm_dp_sideband_msg_tx *msg, int port_num,
>>>   				  u8 vcpi, uint16_t pbn,
>>>   				  u8 number_sdp_streams,
>>>   				  u8 *sdp_stream_sink)
>>> @@ -1062,10 +1056,9 @@ static int build_allocate_payload(struct drm_dp_sideband_msg_tx *msg, int port_n
>>>   		   number_sdp_streams);
>>>   	drm_dp_encode_sideband_req(&req, msg);
>>>   	msg->path_msg = true;
>>> -	return 0;
>>>   }
>>>   
>>> -static int build_power_updown_phy(struct drm_dp_sideband_msg_tx *msg,
>>> +static void build_power_updown_phy(struct drm_dp_sideband_msg_tx *msg,
>>>   				  int port_num, bool power_up)
>>>   {
>>>   	struct drm_dp_sideband_msg_req_body req;
>>> @@ -1078,7 +1071,6 @@ static int build_power_updown_phy(struct drm_dp_sideband_msg_tx *msg,
>>>   	req.u.port_num.port_number = port_num;
>>>   	drm_dp_encode_sideband_req(&req, msg);
>>>   	msg->path_msg = true;
>>> -	return 0;
>>>   }
>>>   
>>>   static int drm_dp_mst_assign_payload_id(struct drm_dp_mst_topology_mgr *mgr,
>>> @@ -1744,14 +1736,13 @@ static u8 drm_dp_calculate_rad(struct drm_dp_mst_port *port,
>>>    */
>>>   static bool drm_dp_port_setup_pdt(struct drm_dp_mst_port *port)
>>>   {
>>> -	int ret;
>>>   	u8 rad[6], lct;
>>>   	bool send_link = false;
>>>   	switch (port->pdt) {
>>>   	case DP_PEER_DEVICE_DP_LEGACY_CONV:
>>>   	case DP_PEER_DEVICE_SST_SINK:
>>>   		/* add i2c over sideband */
>>> -		ret = drm_dp_mst_register_i2c_bus(&port->aux);
>>> +		drm_dp_mst_register_i2c_bus(&port->aux);
>>>   		break;
>>>   	case DP_PEER_DEVICE_MST_BRANCHING:
>>>   		lct = drm_dp_calculate_rad(port, rad);
>>> @@ -1821,25 +1812,20 @@ ssize_t drm_dp_mst_dpcd_write(struct drm_dp_aux *aux,
>>>   
>>>   static void drm_dp_check_mstb_guid(struct drm_dp_mst_branch *mstb, u8 *guid)
>>>   {
>>> -	int ret;
>>> -
>>>   	memcpy(mstb->guid, guid, 16);
>>>   
>>>   	if (!drm_dp_validate_guid(mstb->mgr, mstb->guid)) {
>>>   		if (mstb->port_parent) {
>>> -			ret = drm_dp_send_dpcd_write(
>>> -					mstb->mgr,
>>> -					mstb->port_parent,
>>> -					DP_GUID,
>>> -					16,
>>> -					mstb->guid);
>>> +			drm_dp_send_dpcd_write(mstb->mgr,
>>> +					       mstb->port_parent,
>>> +					       DP_GUID,
>>> +					       16,
>>> +					       mstb->guid);
>>>   		} else {
>>> -
>>> -			ret = drm_dp_dpcd_write(
>>> -					mstb->mgr->aux,
>>> -					DP_GUID,
>>> -					mstb->guid,
>>> -					16);
>>> +			drm_dp_dpcd_write(mstb->mgr->aux,
>>> +					  DP_GUID,
>>> +					  mstb->guid,
>>> +					  16);
>>>   		}
>>>   	}
>>>   }
>>> @@ -2195,7 +2181,7 @@ static bool drm_dp_validate_guid(struct drm_dp_mst_topology_mgr *mgr,
>>>   	return false;
>>>   }
>>>   
>>> -static int build_dpcd_read(struct drm_dp_sideband_msg_tx *msg, u8 port_num, u32 offset, u8 num_bytes)
>>> +static void build_dpcd_read(struct drm_dp_sideband_msg_tx *msg, u8 port_num, u32 offset, u8 num_bytes)
>>>   {
>>>   	struct drm_dp_sideband_msg_req_body req;
>>>   
>>> @@ -2204,8 +2190,6 @@ static int build_dpcd_read(struct drm_dp_sideband_msg_tx *msg, u8 port_num, u32
>>>   	req.u.dpcd_read.dpcd_address = offset;
>>>   	req.u.dpcd_read.num_bytes = num_bytes;
>>>   	drm_dp_encode_sideband_req(&req, msg);
>>> -
>>> -	return 0;
>>>   }
>>>   
>>>   static int drm_dp_send_sideband_msg(struct drm_dp_mst_topology_mgr *mgr,
>>> @@ -2427,14 +2411,14 @@ static void drm_dp_send_link_address(struct drm_dp_mst_topology_mgr *mgr,
>>>   {
>>>   	struct drm_dp_sideband_msg_tx *txmsg;
>>>   	struct drm_dp_link_address_ack_reply *reply;
>>> -	int i, len, ret;
>>> +	int i, ret;
>>>   
>>>   	txmsg = kzalloc(sizeof(*txmsg), GFP_KERNEL);
>>>   	if (!txmsg)
>>>   		return;
>>>   
>>>   	txmsg->dst = mstb;
>>> -	len = build_link_address(txmsg);
>>> +	build_link_address(txmsg);
>>>   
>>>   	mstb->link_address_sent = true;
>>>   	drm_dp_queue_down_tx(mgr, txmsg);
>>> @@ -2476,7 +2460,6 @@ drm_dp_send_enum_path_resources(struct drm_dp_mst_topology_mgr *mgr,
>>>   {
>>>   	struct drm_dp_enum_path_resources_ack_reply *path_res;
>>>   	struct drm_dp_sideband_msg_tx *txmsg;
>>> -	int len;
>>>   	int ret;
>>>   
>>>   	txmsg = kzalloc(sizeof(*txmsg), GFP_KERNEL);
>>> @@ -2484,7 +2467,7 @@ drm_dp_send_enum_path_resources(struct drm_dp_mst_topology_mgr *mgr,
>>>   		return -ENOMEM;
>>>   
>>>   	txmsg->dst = mstb;
>>> -	len = build_enum_path_resources(txmsg, port->port_num);
>>> +	build_enum_path_resources(txmsg, port->port_num);
>>>   
>>>   	drm_dp_queue_down_tx(mgr, txmsg);
>>>   
>>> @@ -2567,7 +2550,7 @@ static int drm_dp_payload_send_msg(struct drm_dp_mst_topology_mgr *mgr,
>>>   {
>>>   	struct drm_dp_sideband_msg_tx *txmsg;
>>>   	struct drm_dp_mst_branch *mstb;
>>> -	int len, ret, port_num;
>>> +	int ret, port_num;
>>>   	u8 sinks[DRM_DP_MAX_SDP_STREAMS];
>>>   	int i;
>>>   
>>> @@ -2592,9 +2575,9 @@ static int drm_dp_payload_send_msg(struct drm_dp_mst_topology_mgr *mgr,
>>>   		sinks[i] = i;
>>>   
>>>   	txmsg->dst = mstb;
>>> -	len = build_allocate_payload(txmsg, port_num,
>>> -				     id,
>>> -				     pbn, port->num_sdp_streams, sinks);
>>> +	build_allocate_payload(txmsg, port_num,
>>> +			       id,
>>> +			       pbn, port->num_sdp_streams, sinks);
>>>   
>>>   	drm_dp_queue_down_tx(mgr, txmsg);
>>>   
>>> @@ -2623,7 +2606,7 @@ int drm_dp_send_power_updown_phy(struct drm_dp_mst_topology_mgr *mgr,
>>>   				 struct drm_dp_mst_port *port, bool power_up)
>>>   {
>>>   	struct drm_dp_sideband_msg_tx *txmsg;
>>> -	int len, ret;
>>> +	int ret;
>>>   
>>>   	port = drm_dp_mst_topology_get_port_validated(mgr, port);
>>>   	if (!port)
>>> @@ -2636,7 +2619,7 @@ int drm_dp_send_power_updown_phy(struct drm_dp_mst_topology_mgr *mgr,
>>>   	}
>>>   
>>>   	txmsg->dst = port->parent;
>>> -	len = build_power_updown_phy(txmsg, port->port_num, power_up);
>>> +	build_power_updown_phy(txmsg, port->port_num, power_up);
>>>   	drm_dp_queue_down_tx(mgr, txmsg);
>>>   
>>>   	ret = drm_dp_mst_wait_tx_reply(port->parent, txmsg);
>>> @@ -2856,7 +2839,6 @@ static int drm_dp_send_dpcd_read(struct drm_dp_mst_topology_mgr *mgr,
>>>   				 struct drm_dp_mst_port *port,
>>>   				 int offset, int size, u8 *bytes)
>>>   {
>>> -	int len;
>>>   	int ret = 0;
>>>   	struct drm_dp_sideband_msg_tx *txmsg;
>>>   	struct drm_dp_mst_branch *mstb;
>>> @@ -2871,7 +2853,7 @@ static int drm_dp_send_dpcd_read(struct drm_dp_mst_topology_mgr *mgr,
>>>   		goto fail_put;
>>>   	}
>>>   
>>> -	len = build_dpcd_read(txmsg, port->port_num, offset, size);
>>> +	build_dpcd_read(txmsg, port->port_num, offset, size);
>>>   	txmsg->dst = port->parent;
>>>   
>>>   	drm_dp_queue_down_tx(mgr, txmsg);
>>> @@ -2909,7 +2891,6 @@ static int drm_dp_send_dpcd_write(struct drm_dp_mst_topology_mgr *mgr,
>>>   				  struct drm_dp_mst_port *port,
>>>   				  int offset, int size, u8 *bytes)
>>>   {
>>> -	int len;
>>>   	int ret;
>>>   	struct drm_dp_sideband_msg_tx *txmsg;
>>>   	struct drm_dp_mst_branch *mstb;
>>> @@ -2924,7 +2905,7 @@ static int drm_dp_send_dpcd_write(struct drm_dp_mst_topology_mgr *mgr,
>>>   		goto fail_put;
>>>   	}
>>>   
>>> -	len = build_dpcd_write(txmsg, port->port_num, offset, size, bytes);
>>> +	build_dpcd_write(txmsg, port->port_num, offset, size, bytes);
>>>   	txmsg->dst = mstb;
>>>   
>>>   	drm_dp_queue_down_tx(mgr, txmsg);
>>> @@ -3147,7 +3128,7 @@ static bool drm_dp_get_one_sb_msg(struct drm_dp_mst_topology_mgr *mgr, bool up)
>>>   {
>>>   	int len;
>>>   	u8 replyblock[32];
>>> -	int replylen, origlen, curreply;
>>> +	int replylen, curreply;
>>>   	int ret;
>>>   	struct drm_dp_sideband_msg_rx *msg;
>>>   	int basereg = up ? DP_SIDEBAND_MSG_UP_REQ_BASE : DP_SIDEBAND_MSG_DOWN_REP_BASE;
>>> @@ -3167,7 +3148,6 @@ static bool drm_dp_get_one_sb_msg(struct drm_dp_mst_topology_mgr *mgr, bool up)
>>>   	}
>>>   	replylen = msg->curchunk_len + msg->curchunk_hdrlen;
>>>   
>>> -	origlen = replylen;
>>>   	replylen -= len;
>>>   	curreply = len;
>>>   	while (replylen > 0) {
>>> @@ -3959,17 +3939,16 @@ void drm_dp_mst_dump_topology(struct seq_file *m,
>>>   	mutex_lock(&mgr->lock);
>>>   	if (mgr->mst_primary) {
>>>   		u8 buf[DP_PAYLOAD_TABLE_SIZE];
>>> -		int ret;
>>>   
>>> -		ret = drm_dp_dpcd_read(mgr->aux, DP_DPCD_REV, buf, DP_RECEIVER_CAP_SIZE);
>>> +		drm_dp_dpcd_read(mgr->aux, DP_DPCD_REV, buf, DP_RECEIVER_CAP_SIZE);
>>>   		seq_printf(m, "dpcd: %*ph\n", DP_RECEIVER_CAP_SIZE, buf);
>>> -		ret = drm_dp_dpcd_read(mgr->aux, DP_FAUX_CAP, buf, 2);
>>> +		drm_dp_dpcd_read(mgr->aux, DP_FAUX_CAP, buf, 2);
>>>   		seq_printf(m, "faux/mst: %*ph\n", 2, buf);
>>> -		ret = drm_dp_dpcd_read(mgr->aux, DP_MSTM_CTRL, buf, 1);
>>> +		drm_dp_dpcd_read(mgr->aux, DP_MSTM_CTRL, buf, 1);
>>>   		seq_printf(m, "mst ctrl: %*ph\n", 1, buf);
>>>   
>>>   		/* dump the standard OUI branch header */
>>> -		ret = drm_dp_dpcd_read(mgr->aux, DP_BRANCH_OUI, buf, DP_BRANCH_OUI_HEADER_SIZE);
>>> +		drm_dp_dpcd_read(mgr->aux, DP_BRANCH_OUI, buf, DP_BRANCH_OUI_HEADER_SIZE);
>>>   		seq_printf(m, "branch oui: %*phN devid: ", 3, buf);
>>>   		for (i = 0x3; i < 0x8 && buf[i]; i++)
>>>   			seq_printf(m, "%c", buf[i]);

-- 
Jani Nikula, Intel Open Source Graphics Center
