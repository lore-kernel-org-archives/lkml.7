Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0253C43603
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 16:47:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A733A2081B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 16:47:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728894AbfLDQrd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 11:47:33 -0500
Received: from mga07.intel.com ([134.134.136.100]:34019 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726934AbfLDQrc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 11:47:32 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Dec 2019 08:47:32 -0800
X-IronPort-AV: E=Sophos;i="5.69,277,1571727600"; 
   d="scan'208";a="205452139"
Received: from huberth-mobl4.ger.corp.intel.com (HELO localhost) ([10.252.34.172])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Dec 2019 08:47:28 -0800
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Benjamin Gaignard <benjamin.gaignard@st.com>,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        sean@poorly.run, airlied@linux.ie, daniel@ffwll.ch
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Benjamin Gaignard <benjamin.gaignard@st.com>
Subject: Re: [PATCH v3] drm/dp_mst: Fix W=1 warnings
In-Reply-To: <20191128135057.20020-1-benjamin.gaignard@st.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20191128135057.20020-1-benjamin.gaignard@st.com>
Date:   Wed, 04 Dec 2019 18:47:33 +0200
Message-ID: <878snsvxzu.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Nov 2019, Benjamin Gaignard <benjamin.gaignard@st.com> wrote:
> Fix the warnings that show up with W=1.
> They are all about unused but set variables.
> If functions returns are not used anymore make them void.
>
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
> ---
> CC: Jani Nikula <jani.nikula@linux.intel.com>
>
> changes in version 3:
> - remove the hunk that may conflict with c485e2c97dae 
>   ("drm/dp_mst: Refactor pdt setup/teardown, add more locking")
>
> changes in version 2:
> - fix indentations
> - when possible change functions prototype to void
>
> drivers/gpu/drm/drm_dp_mst_topology.c | 83 +++++++++++++----------------------
>  1 file changed, 31 insertions(+), 52 deletions(-)
>
> diff --git a/drivers/gpu/drm/drm_dp_mst_topology.c b/drivers/gpu/drm/drm_dp_mst_topology.c
> index 1437bc46368b..d5cb5688b5dd 100644
> --- a/drivers/gpu/drm/drm_dp_mst_topology.c
> +++ b/drivers/gpu/drm/drm_dp_mst_topology.c
> @@ -674,7 +674,6 @@ static bool drm_dp_sideband_msg_build(struct drm_dp_sideband_msg_rx *msg,
>  				      u8 *replybuf, u8 replybuflen, bool hdr)
>  {
>  	int ret;
> -	u8 crc4;
>  
>  	if (hdr) {
>  		u8 hdrlen;
> @@ -716,8 +715,6 @@ static bool drm_dp_sideband_msg_build(struct drm_dp_sideband_msg_rx *msg,
>  	}
>  
>  	if (msg->curchunk_idx >= msg->curchunk_len) {
> -		/* do CRC */
> -		crc4 = drm_dp_msg_data_crc4(msg->chunk, msg->curchunk_len - 1);

Again, someone needs to check if crc4 should be *used* instead of thrown
away. Blindly throwing stuff out is not the way to go.

BR,
Jani.

>  		/* copy chunk into bigger msg */
>  		memcpy(&msg->msg[msg->curlen], msg->chunk, msg->curchunk_len - 1);
>  		msg->curlen += msg->curchunk_len - 1;
> @@ -1014,7 +1011,7 @@ static bool drm_dp_sideband_parse_req(struct drm_dp_sideband_msg_rx *raw,
>  	}
>  }
>  
> -static int build_dpcd_write(struct drm_dp_sideband_msg_tx *msg, u8 port_num, u32 offset, u8 num_bytes, u8 *bytes)
> +static void build_dpcd_write(struct drm_dp_sideband_msg_tx *msg, u8 port_num, u32 offset, u8 num_bytes, u8 *bytes)
>  {
>  	struct drm_dp_sideband_msg_req_body req;
>  
> @@ -1024,17 +1021,14 @@ static int build_dpcd_write(struct drm_dp_sideband_msg_tx *msg, u8 port_num, u32
>  	req.u.dpcd_write.num_bytes = num_bytes;
>  	req.u.dpcd_write.bytes = bytes;
>  	drm_dp_encode_sideband_req(&req, msg);
> -
> -	return 0;
>  }
>  
> -static int build_link_address(struct drm_dp_sideband_msg_tx *msg)
> +static void build_link_address(struct drm_dp_sideband_msg_tx *msg)
>  {
>  	struct drm_dp_sideband_msg_req_body req;
>  
>  	req.req_type = DP_LINK_ADDRESS;
>  	drm_dp_encode_sideband_req(&req, msg);
> -	return 0;
>  }
>  
>  static int build_enum_path_resources(struct drm_dp_sideband_msg_tx *msg, int port_num)
> @@ -1048,7 +1042,7 @@ static int build_enum_path_resources(struct drm_dp_sideband_msg_tx *msg, int por
>  	return 0;
>  }
>  
> -static int build_allocate_payload(struct drm_dp_sideband_msg_tx *msg, int port_num,
> +static void build_allocate_payload(struct drm_dp_sideband_msg_tx *msg, int port_num,
>  				  u8 vcpi, uint16_t pbn,
>  				  u8 number_sdp_streams,
>  				  u8 *sdp_stream_sink)
> @@ -1064,10 +1058,9 @@ static int build_allocate_payload(struct drm_dp_sideband_msg_tx *msg, int port_n
>  		   number_sdp_streams);
>  	drm_dp_encode_sideband_req(&req, msg);
>  	msg->path_msg = true;
> -	return 0;
>  }
>  
> -static int build_power_updown_phy(struct drm_dp_sideband_msg_tx *msg,
> +static void build_power_updown_phy(struct drm_dp_sideband_msg_tx *msg,
>  				  int port_num, bool power_up)
>  {
>  	struct drm_dp_sideband_msg_req_body req;
> @@ -1080,7 +1073,6 @@ static int build_power_updown_phy(struct drm_dp_sideband_msg_tx *msg,
>  	req.u.port_num.port_number = port_num;
>  	drm_dp_encode_sideband_req(&req, msg);
>  	msg->path_msg = true;
> -	return 0;
>  }
>  
>  static int drm_dp_mst_assign_payload_id(struct drm_dp_mst_topology_mgr *mgr,
> @@ -1746,14 +1738,13 @@ static u8 drm_dp_calculate_rad(struct drm_dp_mst_port *port,
>   */
>  static bool drm_dp_port_setup_pdt(struct drm_dp_mst_port *port)
>  {
> -	int ret;
>  	u8 rad[6], lct;
>  	bool send_link = false;
>  	switch (port->pdt) {
>  	case DP_PEER_DEVICE_DP_LEGACY_CONV:
>  	case DP_PEER_DEVICE_SST_SINK:
>  		/* add i2c over sideband */
> -		ret = drm_dp_mst_register_i2c_bus(&port->aux);
> +		drm_dp_mst_register_i2c_bus(&port->aux);
>  		break;
>  	case DP_PEER_DEVICE_MST_BRANCHING:
>  		lct = drm_dp_calculate_rad(port, rad);
> @@ -1823,25 +1814,20 @@ ssize_t drm_dp_mst_dpcd_write(struct drm_dp_aux *aux,
>  
>  static void drm_dp_check_mstb_guid(struct drm_dp_mst_branch *mstb, u8 *guid)
>  {
> -	int ret;
> -
>  	memcpy(mstb->guid, guid, 16);
>  
>  	if (!drm_dp_validate_guid(mstb->mgr, mstb->guid)) {
>  		if (mstb->port_parent) {
> -			ret = drm_dp_send_dpcd_write(
> -					mstb->mgr,
> -					mstb->port_parent,
> -					DP_GUID,
> -					16,
> -					mstb->guid);
> +			drm_dp_send_dpcd_write(mstb->mgr,
> +					       mstb->port_parent,
> +					       DP_GUID,
> +					       16,
> +					       mstb->guid);
>  		} else {
> -
> -			ret = drm_dp_dpcd_write(
> -					mstb->mgr->aux,
> -					DP_GUID,
> -					mstb->guid,
> -					16);
> +			drm_dp_dpcd_write(mstb->mgr->aux,
> +					  DP_GUID,
> +					  mstb->guid,
> +					  16);
>  		}
>  	}
>  }
> @@ -2197,7 +2183,7 @@ static bool drm_dp_validate_guid(struct drm_dp_mst_topology_mgr *mgr,
>  	return false;
>  }
>  
> -static int build_dpcd_read(struct drm_dp_sideband_msg_tx *msg, u8 port_num, u32 offset, u8 num_bytes)
> +static void build_dpcd_read(struct drm_dp_sideband_msg_tx *msg, u8 port_num, u32 offset, u8 num_bytes)
>  {
>  	struct drm_dp_sideband_msg_req_body req;
>  
> @@ -2206,8 +2192,6 @@ static int build_dpcd_read(struct drm_dp_sideband_msg_tx *msg, u8 port_num, u32
>  	req.u.dpcd_read.dpcd_address = offset;
>  	req.u.dpcd_read.num_bytes = num_bytes;
>  	drm_dp_encode_sideband_req(&req, msg);
> -
> -	return 0;
>  }
>  
>  static int drm_dp_send_sideband_msg(struct drm_dp_mst_topology_mgr *mgr,
> @@ -2429,14 +2413,14 @@ static void drm_dp_send_link_address(struct drm_dp_mst_topology_mgr *mgr,
>  {
>  	struct drm_dp_sideband_msg_tx *txmsg;
>  	struct drm_dp_link_address_ack_reply *reply;
> -	int i, len, ret;
> +	int i, ret;
>  
>  	txmsg = kzalloc(sizeof(*txmsg), GFP_KERNEL);
>  	if (!txmsg)
>  		return;
>  
>  	txmsg->dst = mstb;
> -	len = build_link_address(txmsg);
> +	build_link_address(txmsg);
>  
>  	mstb->link_address_sent = true;
>  	drm_dp_queue_down_tx(mgr, txmsg);
> @@ -2478,7 +2462,6 @@ drm_dp_send_enum_path_resources(struct drm_dp_mst_topology_mgr *mgr,
>  {
>  	struct drm_dp_enum_path_resources_ack_reply *path_res;
>  	struct drm_dp_sideband_msg_tx *txmsg;
> -	int len;
>  	int ret;
>  
>  	txmsg = kzalloc(sizeof(*txmsg), GFP_KERNEL);
> @@ -2486,7 +2469,7 @@ drm_dp_send_enum_path_resources(struct drm_dp_mst_topology_mgr *mgr,
>  		return -ENOMEM;
>  
>  	txmsg->dst = mstb;
> -	len = build_enum_path_resources(txmsg, port->port_num);
> +	build_enum_path_resources(txmsg, port->port_num);
>  
>  	drm_dp_queue_down_tx(mgr, txmsg);
>  
> @@ -2569,7 +2552,7 @@ static int drm_dp_payload_send_msg(struct drm_dp_mst_topology_mgr *mgr,
>  {
>  	struct drm_dp_sideband_msg_tx *txmsg;
>  	struct drm_dp_mst_branch *mstb;
> -	int len, ret, port_num;
> +	int ret, port_num;
>  	u8 sinks[DRM_DP_MAX_SDP_STREAMS];
>  	int i;
>  
> @@ -2594,9 +2577,9 @@ static int drm_dp_payload_send_msg(struct drm_dp_mst_topology_mgr *mgr,
>  		sinks[i] = i;
>  
>  	txmsg->dst = mstb;
> -	len = build_allocate_payload(txmsg, port_num,
> -				     id,
> -				     pbn, port->num_sdp_streams, sinks);
> +	build_allocate_payload(txmsg, port_num,
> +			       id,
> +			       pbn, port->num_sdp_streams, sinks);
>  
>  	drm_dp_queue_down_tx(mgr, txmsg);
>  
> @@ -2625,7 +2608,7 @@ int drm_dp_send_power_updown_phy(struct drm_dp_mst_topology_mgr *mgr,
>  				 struct drm_dp_mst_port *port, bool power_up)
>  {
>  	struct drm_dp_sideband_msg_tx *txmsg;
> -	int len, ret;
> +	int ret;
>  
>  	port = drm_dp_mst_topology_get_port_validated(mgr, port);
>  	if (!port)
> @@ -2638,7 +2621,7 @@ int drm_dp_send_power_updown_phy(struct drm_dp_mst_topology_mgr *mgr,
>  	}
>  
>  	txmsg->dst = port->parent;
> -	len = build_power_updown_phy(txmsg, port->port_num, power_up);
> +	build_power_updown_phy(txmsg, port->port_num, power_up);
>  	drm_dp_queue_down_tx(mgr, txmsg);
>  
>  	ret = drm_dp_mst_wait_tx_reply(port->parent, txmsg);
> @@ -2858,7 +2841,6 @@ static int drm_dp_send_dpcd_read(struct drm_dp_mst_topology_mgr *mgr,
>  				 struct drm_dp_mst_port *port,
>  				 int offset, int size, u8 *bytes)
>  {
> -	int len;
>  	int ret = 0;
>  	struct drm_dp_sideband_msg_tx *txmsg;
>  	struct drm_dp_mst_branch *mstb;
> @@ -2873,7 +2855,7 @@ static int drm_dp_send_dpcd_read(struct drm_dp_mst_topology_mgr *mgr,
>  		goto fail_put;
>  	}
>  
> -	len = build_dpcd_read(txmsg, port->port_num, offset, size);
> +	build_dpcd_read(txmsg, port->port_num, offset, size);
>  	txmsg->dst = port->parent;
>  
>  	drm_dp_queue_down_tx(mgr, txmsg);
> @@ -2911,7 +2893,6 @@ static int drm_dp_send_dpcd_write(struct drm_dp_mst_topology_mgr *mgr,
>  				  struct drm_dp_mst_port *port,
>  				  int offset, int size, u8 *bytes)
>  {
> -	int len;
>  	int ret;
>  	struct drm_dp_sideband_msg_tx *txmsg;
>  	struct drm_dp_mst_branch *mstb;
> @@ -2926,7 +2907,7 @@ static int drm_dp_send_dpcd_write(struct drm_dp_mst_topology_mgr *mgr,
>  		goto fail_put;
>  	}
>  
> -	len = build_dpcd_write(txmsg, port->port_num, offset, size, bytes);
> +	build_dpcd_write(txmsg, port->port_num, offset, size, bytes);
>  	txmsg->dst = mstb;
>  
>  	drm_dp_queue_down_tx(mgr, txmsg);
> @@ -3149,7 +3130,7 @@ static bool drm_dp_get_one_sb_msg(struct drm_dp_mst_topology_mgr *mgr, bool up)
>  {
>  	int len;
>  	u8 replyblock[32];
> -	int replylen, origlen, curreply;
> +	int replylen, curreply;
>  	int ret;
>  	struct drm_dp_sideband_msg_rx *msg;
>  	int basereg = up ? DP_SIDEBAND_MSG_UP_REQ_BASE : DP_SIDEBAND_MSG_DOWN_REP_BASE;
> @@ -3169,7 +3150,6 @@ static bool drm_dp_get_one_sb_msg(struct drm_dp_mst_topology_mgr *mgr, bool up)
>  	}
>  	replylen = msg->curchunk_len + msg->curchunk_hdrlen;
>  
> -	origlen = replylen;
>  	replylen -= len;
>  	curreply = len;
>  	while (replylen > 0) {
> @@ -3961,17 +3941,16 @@ void drm_dp_mst_dump_topology(struct seq_file *m,
>  	mutex_lock(&mgr->lock);
>  	if (mgr->mst_primary) {
>  		u8 buf[DP_PAYLOAD_TABLE_SIZE];
> -		int ret;
>  
> -		ret = drm_dp_dpcd_read(mgr->aux, DP_DPCD_REV, buf, DP_RECEIVER_CAP_SIZE);
> +		drm_dp_dpcd_read(mgr->aux, DP_DPCD_REV, buf, DP_RECEIVER_CAP_SIZE);
>  		seq_printf(m, "dpcd: %*ph\n", DP_RECEIVER_CAP_SIZE, buf);
> -		ret = drm_dp_dpcd_read(mgr->aux, DP_FAUX_CAP, buf, 2);
> +		drm_dp_dpcd_read(mgr->aux, DP_FAUX_CAP, buf, 2);
>  		seq_printf(m, "faux/mst: %*ph\n", 2, buf);
> -		ret = drm_dp_dpcd_read(mgr->aux, DP_MSTM_CTRL, buf, 1);
> +		drm_dp_dpcd_read(mgr->aux, DP_MSTM_CTRL, buf, 1);
>  		seq_printf(m, "mst ctrl: %*ph\n", 1, buf);
>  
>  		/* dump the standard OUI branch header */
> -		ret = drm_dp_dpcd_read(mgr->aux, DP_BRANCH_OUI, buf, DP_BRANCH_OUI_HEADER_SIZE);
> +		drm_dp_dpcd_read(mgr->aux, DP_BRANCH_OUI, buf, DP_BRANCH_OUI_HEADER_SIZE);
>  		seq_printf(m, "branch oui: %*phN devid: ", 3, buf);
>  		for (i = 0x3; i < 0x8 && buf[i]; i++)
>  			seq_printf(m, "%c", buf[i]);

-- 
Jani Nikula, Intel Open Source Graphics Center
